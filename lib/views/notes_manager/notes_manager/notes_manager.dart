import 'package:flutter/material.dart';
import 'package:scotti_seguros/consts/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_cubit.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_state.dart';
import 'package:scotti_seguros/enums/status_base_enum.dart';
import 'package:scotti_seguros/views/notes_manager/notes_manager/widgets/card_add_new.dart';
import 'package:scotti_seguros/views/notes_manager/notes_manager/widgets/card_note.dart';
import 'package:scotti_seguros/views/notes_manager/view_note/view_note.dart';

class NotesManager extends StatefulWidget {
  const NotesManager({super.key});

  @override
  State<NotesManager> createState() => _NotesManagerState();
}

class _NotesManagerState extends State<NotesManager> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<NotesManagerCubit>(context).getAllNotes();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    int crossAxisCount = _getCrossCount(screenSize.width);

    return BlocConsumer<NotesManagerCubit, NotesManagerState>(
        listener: (context, state) {
      if (state.status == StatusBaseEnum.success) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewNote(),
          ),
        );
        BlocProvider.of<NotesManagerCubit>(context)
            .setStatus(StatusBaseEnum.initial);
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Center(
            child: Text(
              'Scotti Seguros',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: AppColors.primary,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              if (state.notes.isEmpty) ...[
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                        children: [
                          const TextSpan(
                              text:
                                  "Nenhuma nota cadastrada ainda.\nClique em "),
                          TextSpan(
                            text: "+",
                            style: const TextStyle(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(text: " para adicionar uma!"),
                        ],
                      ),
                    ),
                  ),
                ),
              ] else ...[
                ...List.generate(
                  state.notes.length,
                  (i) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    margin:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    child: ListTile(
                      leading: const Icon(Icons.sticky_note_2,
                          color: AppColors.primary),
                      title: Text(
                        state.notes[i].title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        state.notes[i].description.isNotEmpty
                            ? state.notes[i].description
                            : "Sem descrição",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing:
                          const Icon(Icons.chevron_right, color: Colors.grey),
                      onTap: () {
                        BlocProvider.of<NotesManagerCubit>(context)
                            .getNoteById(state.notes[i].id!);
                      },
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        body: GridView.count(
          padding: const EdgeInsets.all(20),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            CardAddNew(),
            ...List.generate(
              state.notes.length,
              (i) => CardNote(
                note: state.notes[i],
                icon: Icons.info,
                onPressed: () => BlocProvider.of<NotesManagerCubit>(context)
                    .getNoteById(state.notes[i].id!),
              ),
            ),
          ],
        ),
      );
    });
  }

  int _getCrossCount(double screenWidth) {
    if (screenWidth > 1300) {
      return 4;
    } else if (screenWidth < 1300 && screenWidth > 950) {
      return 3;
    } else if (screenWidth < 950 && screenWidth > 690) {
      return 2;
    } else {
      return 1;
    }
  }
}
