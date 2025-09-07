import 'package:bloc/bloc.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_state.dart';
import 'package:scotti_seguros/models/notes_manager/notes_manager.dart';
import 'package:scotti_seguros/services/notes_manager/notes_manager_repository.dart';

class NotesManagerCubit extends Cubit<NotesManagerState> {
  final NotesManagerRepository repository;

  NotesManagerCubit(this.repository) : super(const NotesManagerState());

  void setisAddingNew(bool value) {
    emit(state.copyWith(isAddingNew: value));
  }

  Future<void> getAllNotes() async {
    final notes = await repository.getAllNotes();
    emit(state.copyWith(notes: notes));
  }

  Future<Note> getNoteById(int id) async {
    return await repository.getNoteById(id);
  }

  Future<void> addNote(Note note) async {
    await repository.addNote(note);
    await getAllNotes();
  }

  Future<int> updateNote(Note note) async {
    return await repository.updateNote(note);
  }

  Future<void> removeNote(int id) async {
    await repository.deleteNote(id);
    await getAllNotes();
  }
}
