import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scotti_seguros/common/buttons/default_button.dart';
import 'package:scotti_seguros/common/functions/show_dialog.dart';
import 'package:scotti_seguros/common/functions/show_snackbar.dart';
import 'package:scotti_seguros/consts/app_colors.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_cubit.dart';
import 'package:scotti_seguros/enums/semantic_type_enum.dart';
import 'package:scotti_seguros/models/notes_manager/notes_manager.dart';

class ViewNote extends StatelessWidget {
  final Note note;

  const ViewNote({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    final observationController = TextEditingController(
      text: note.observation ?? "",
    );

    return Scaffold(
      backgroundColor: Color(0xFF414988),
      appBar: AppBar(
        title: Expanded(
          child: Center(
            child: Text(
              'Scotti Seguros',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => {Navigator.pop(context)},
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Divider(color: AppColors.secondary),
                  Text(
                    note.description,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: observationController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    maxLines: 15,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DefaultButton(
                        text: 'Deletar',
                        backgroundColor: AppColors.errorDefault,
                        onPressed: () => {
                          ShowDialogBox.show(
                            context,
                            title: 'Deseja mesmo deletar?',
                            message: 'Esta ação não pode ser revertida.',
                            semanticType: SemanticType.success,
                            primaryButtonText: 'Deletar',
                            primaryButtonColor: AppColors.errorDefault,
                            onPrimaryButtonPressed: () async {
                              await BlocProvider.of<NotesManagerCubit>(context)
                                  .removeNote(note.id!);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              ShowSnackbar.show(context,
                                  message: 'Nota Deletada com Sucesso',
                                  semanticType: SemanticType.success);
                            },
                            secondaryButtonText: 'Cancelar',
                            secondaryButtonColor: AppColors.primary,
                            onSecondaryButtonPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        },
                      ),
                      DefaultButton(
                        text: 'Salvar',
                        backgroundColor: AppColors.primary,
                        onPressed: () async {
                          var updatedNote = Note(
                              id: note.id,
                              title: note.title,
                              description: note.description,
                              observation: observationController.text);
                          var result =
                              await BlocProvider.of<NotesManagerCubit>(context)
                                  .updateNote(updatedNote);
                          if (result == 1) {
                            if (!context.mounted) return;

                            ShowSnackbar.show(
                              context,
                              message: 'Nota Atualizada com Sucesso!',
                              semanticType: SemanticType.success,
                            );
                          } else {
                            if (!context.mounted) return;

                            ShowSnackbar.show(
                              context,
                              message: 'Ocorreu um erro ao atualizar a nota.',
                              semanticType: SemanticType.error,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
