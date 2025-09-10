import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scotti_seguros/common/functions/show_dialog.dart';
import 'package:scotti_seguros/common/functions/show_snackbar.dart';
import 'package:scotti_seguros/consts/app_colors.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_cubit.dart';
import 'package:scotti_seguros/enums/semantic_type_enum.dart';
import 'package:scotti_seguros/models/notes_manager/notes_manager.dart';

class CardNote extends StatelessWidget {
  final VoidCallback onPressed;
  final Note note;
  final IconData icon;

  const CardNote({
    required this.note,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.cancel),
                  color: AppColors.secondary,
                  iconSize: 28,
                  onPressed: () {
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
                        ShowSnackbar.show(context,
                            message: 'Nota Deletada com Sucesso',
                            semanticType: SemanticType.success);
                      },
                      secondaryButtonText: 'Cancelar',
                      secondaryButtonColor: AppColors.primary,
                      onSecondaryButtonPressed: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: AppColors.primary,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    note.title,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    note.description,
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
