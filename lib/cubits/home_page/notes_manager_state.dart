import 'package:scotti_seguros/enums/status_base_enum.dart';
import 'package:scotti_seguros/models/notes_manager/notes_manager.dart';

class NotesManagerState {
  final List<Note> notes;
  final Note selectedNote;
  final bool isAddingNew;
  final bool isEditTitle;
  final bool isEditDescription;
  final StatusBaseEnum status;

  const NotesManagerState({
    this.selectedNote = Note.empty,
    this.notes = const [],
    this.isAddingNew = false,
    this.isEditTitle = false,
    this.isEditDescription = false,
    this.status = StatusBaseEnum.initial,
  });

  NotesManagerState copyWith({
    List<Note>? notes,
    Note? selectedNote,
    bool? isAddingNew,
    bool? isEditTitle,
    bool? isEditDescription,
    StatusBaseEnum? status,
  }) {
    return NotesManagerState(
      notes: notes ?? this.notes,
      selectedNote: selectedNote ?? this.selectedNote,
      isAddingNew: isAddingNew ?? this.isAddingNew,
      isEditTitle: isEditTitle ?? this.isEditTitle,
      isEditDescription: isEditDescription ?? this.isEditDescription,
      status: status ?? this.status,
    );
  }
}
