import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scotti_seguros/common/functions/show_snackbar.dart';
import 'package:scotti_seguros/consts/app_colors.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_cubit.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_state.dart';
import 'package:scotti_seguros/enums/semantic_type_enum.dart';

class HeaderViewNote extends StatefulWidget {
  const HeaderViewNote({
    super.key,
  });

  @override
  State<HeaderViewNote> createState() => _HeaderViewNoteState();
}

class _HeaderViewNoteState extends State<HeaderViewNote> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    final selectedNote = context.read<NotesManagerCubit>().state.selectedNote;
    _titleController = TextEditingController(text: selectedNote.title);
    _descriptionController =
        TextEditingController(text: selectedNote.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesManagerCubit, NotesManagerState>(
      builder: (context, state) {
        return KeyboardListener(
          focusNode: FocusNode()..requestFocus(),
          onKeyEvent: (event) {
            if (event is KeyDownEvent &&
                event.logicalKey == LogicalKeyboardKey.escape) {
              Navigator.pop(context);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  state.isEditTitle
                      ? Expanded(
                          child: TextField(
                            autofocus: true,
                            controller: _titleController,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        )
                      : Expanded(
                          child: Text(
                            state.selectedNote.title,
                            style: const TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<NotesManagerCubit>(context)
                          .setIsEditingTitle(!state.isEditTitle);
                    },
                    icon: Icon(state.isEditTitle ? Icons.close : Icons.edit),
                  ),
                  if (state.isEditTitle)
                    IconButton(
                      onPressed: () async {
                        var result =
                            await BlocProvider.of<NotesManagerCubit>(context)
                                .updateTitle(_titleController.text);
                        showSuccessSnakBar(result);
                      },
                      icon: Icon(Icons.check),
                    ),
                ],
              ),
              const Divider(color: AppColors.secondary),
              Row(
                children: [
                  state.isEditDescription
                      ? Expanded(
                          child: TextField(
                            autofocus: true,
                            controller: _descriptionController,
                            style: const TextStyle(fontSize: 15),
                          ),
                        )
                      : Expanded(
                          child: Text(
                            state.selectedNote.description,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      BlocProvider.of<NotesManagerCubit>(context)
                          .setIsEditingDescription(!state.isEditDescription);
                    },
                    icon: Icon(getDescriptionIcon(
                        state.selectedNote.description,
                        state.isEditDescription)),
                  ),
                  if (state.isEditDescription)
                    IconButton(
                      onPressed: () async {
                        var result =
                            await BlocProvider.of<NotesManagerCubit>(context)
                                .updateDescription(_descriptionController.text);
                        showSuccessSnakBar(result);
                      },
                      icon: Icon(Icons.check),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showSuccessSnakBar(int result) {
    if (result == 1) {
      if (!context.mounted) return;

      ShowSnackbar.show(
        context,
        message: 'Nota Atualizada com Sucesso!',
        semanticType: SemanticType.success,
      );
      context.read<NotesManagerCubit>().getAllNotes();
    } else {
      if (!context.mounted) return;

      ShowSnackbar.show(
        context,
        message: 'Ocorreu um erro ao atualizar a nota.',
        semanticType: SemanticType.error,
      );
    }
  }

  IconData getDescriptionIcon(String description, bool isEditDescription) {
    if (isEditDescription) {
      return Icons.close;
    } else if (description.isEmpty) {
      return Icons.add;
    } else {
      return Icons.edit;
    }
  }
}
