import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scotti_seguros/consts/app_colors.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_cubit.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_state.dart';
import 'package:scotti_seguros/models/notes_manager/notes_manager.dart';

class CardAddNew extends StatefulWidget {
  const CardAddNew({
    super.key,
  });

  @override
  State<CardAddNew> createState() => _CardAddNewState();
}

class _CardAddNewState extends State<CardAddNew> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesManagerCubit, NotesManagerState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: !state.isAddingNew
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.add),
                      color: AppColors.secondary,
                      onPressed: () {
                        BlocProvider.of<NotesManagerCubit>(context)
                            .setisAddingNew(true);
                      },
                    ),
                    Text('Adicionar'),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.cancel),
                          color: AppColors.primary,
                          iconSize: 28,
                          onPressed: () {
                            BlocProvider.of<NotesManagerCubit>(context)
                                .setisAddingNew(false);
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              labelText: 'Título',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            controller: _descriptionController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              labelText: 'Descrição',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: AppColors.primary,
                                elevation: 3,
                              ),
                              onPressed: () {
                                var note = Note(
                                    title: _titleController.text,
                                    description: _descriptionController.text);
                                BlocProvider.of<NotesManagerCubit>(context)
                                    .addNote(note);
                                BlocProvider.of<NotesManagerCubit>(context)
                                    .getAllNotes();
                                _titleController.clear();
                                _descriptionController.clear();
                              },
                              child: Text(
                                'Salvar',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
