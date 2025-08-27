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
    final box = Hive.box<Note>(notesBox);
    final notes = box.values.toList();
    emit(state.copyWith(notes: notes));
  }

  Future<void> addNote(Note note) async {
    final box = Hive.box<Note>(notesBox);
    await box.add(note);
    getAllNotes();
  }

  Future<void> removeNote(String title) async {
    final box = Hive.box<Note>(notesBox);
    final keyToDelete = box.keys.firstWhere(
      (key) => box.get(key)?.title == title,
      orElse: () => null,
    );

    if (keyToDelete != null) {
      await box.delete(keyToDelete);
      getAllNotes();
    }
  }
}
