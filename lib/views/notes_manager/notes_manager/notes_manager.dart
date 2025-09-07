import 'package:flutter/material.dart';
import 'package:scotti_seguros/consts/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_cubit.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_state.dart';
import 'package:scotti_seguros/views/notes_manager/notes_manager/widgets/card_add_new.dart';
import 'package:scotti_seguros/views/notes_manager/notes_manager/widgets/card_note.dart';

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

    return BlocBuilder<NotesManagerCubit, NotesManagerState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          title: Center(
            child: Text(
              'Scotti Seguros',
              style: TextStyle(color: Colors.white),
            ),
          ),
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {},
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
              (index) => CardNote(
                note: state.notes[index],
                icon: Icons.info,
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
