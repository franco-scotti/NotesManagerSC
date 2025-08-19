import 'package:flutter/material.dart';
import 'package:scotti_seguros/consts/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_cubit.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_state.dart';
import 'package:scotti_seguros/models/notes_manager/notes_manager.dart';
import 'package:scotti_seguros/views/notes_manager/widgets/card_add_new.dart';

class NotesManager extends StatefulWidget {
  const NotesManager({super.key});

  @override
  State<NotesManager> createState() => _NotesManagerState();
}

class _NotesManagerState extends State<NotesManager> {
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
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;

    int crossAxisCount = screenWidth > 600 ? 4 : 2;
    double cardWidth = screenWidth / crossAxisCount - 30;
    return BlocBuilder<NotesManagerCubit, NotesManagerState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: Color(0xFF414988),
        appBar: AppBar(
          title: Expanded(
            child: Center(
              child: Text(
                'scotti seguros',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () => {},
          ),
        ),
        body: GridView.count(
          padding: const EdgeInsets.all(20),
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            CardAddNew(
              cardWidth: cardWidth,
            ),
            ...List.generate(
              state.notes.length,
              (index) => _cardNotes(
                state.notes[index].title,
                state.notes[index].description,
                Icons.info,
                cardWidth: cardWidth,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _cardNotes(
    String title,
    String description,
    IconData icon, {
    required double cardWidth,
  }) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        width: cardWidth,
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
                    BlocProvider.of<NotesManagerCubit>(context)
                        .removeNote(title);
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
                    title,
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    description,
                    style: TextStyle(fontSize: 10),
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
