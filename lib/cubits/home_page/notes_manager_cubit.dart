import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_state.dart';
import 'package:scotti_seguros/models/notes_manager/notes_manager.dart';

class NotesManagerCubit extends Cubit<NotesManagerState> {
  static const notesBox = 'notesBox';

  NotesManagerCubit() : super(const NotesManagerState());

  void setisAddingNew(bool value) {
    emit(state.copyWith(isAddingNew: value));
  }

  Future<void> getAllNotes() async {
    final box = Hive.box(notesBox);
    final notes = box.values.map((e) => Note.fromMap(e)).toList();
    emit(state.copyWith(notes: notes));
  }

  Future<void> addNote(Note note) async {
    final box = Hive.box(notesBox);
    await box.add(note.toMap());
  }

  Future<void> removeNote(String title) async {
    final box = Hive.box(notesBox);
    final Map<dynamic, dynamic> allNotes = box.toMap();

    allNotes.forEach((key, value) {
      if (value['title'] == title) {
        box.delete(key);
      }
    });

    getAllNotes();
  }
}
