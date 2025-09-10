import 'package:bloc/bloc.dart';
import 'package:scotti_seguros/cubits/home_page/notes_manager_state.dart';
import 'package:scotti_seguros/enums/status_base_enum.dart';
import 'package:scotti_seguros/models/notes_manager/notes_manager.dart';
import 'package:scotti_seguros/services/notes_manager/notes_manager_repository.dart';

class NotesManagerCubit extends Cubit<NotesManagerState> {
  final NotesManagerRepository repository;

  NotesManagerCubit(this.repository) : super(const NotesManagerState());

  void setIsAddingNew(bool value) {
    emit(state.copyWith(isAddingNew: value));
  }

  void setIsEditingTitle(bool value) {
    emit(state.copyWith(isEditTitle: value));
  }

  void setIsEditingDescription(bool value) {
    emit(state.copyWith(isEditDescription: value));
  }

  void setStatus(StatusBaseEnum value) {
    emit(state.copyWith(status: value));
  }

  Future<int> updateTitle(String title) async {
    var updatedNote = Note(
      id: state.selectedNote.id,
      title: title,
      description: state.selectedNote.description,
      observation: state.selectedNote.observation,
    );
    var result = await repository.updateNote(updatedNote);
    emit(state.copyWith(selectedNote: updatedNote, isEditTitle: false));
    getAllNotes();
    return result;
  }

  Future<int> updateDescription(String description) async {
    var updatedNote = Note(
      id: state.selectedNote.id,
      title: state.selectedNote.title,
      description: description,
      observation: state.selectedNote.observation,
    );
    var result = repository.updateNote(updatedNote);
    emit(state.copyWith(selectedNote: updatedNote, isEditDescription: false));
    getAllNotes();
    return result;
  }

  Future<void> getAllNotes() async {
    final notes = await repository.getAllNotes();
    emit(state.copyWith(notes: notes));
  }

  Future<void> getNoteById(int id) async {
    emit(state.copyWith(status: StatusBaseEnum.loading));
    await Future.delayed(const Duration(seconds: 1));
    var note = await repository.getNoteById(id);
    emit(state.copyWith(selectedNote: note, status: StatusBaseEnum.success));
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
