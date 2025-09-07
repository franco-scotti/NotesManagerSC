import 'package:scotti_seguros/models/notes_manager/notes_manager.dart';

class NotesManagerState {
  final List<Note> notes;
  final bool isAddingNew;
  final bool isEditTitle;
  final bool isEditDescription;

  const NotesManagerState({
    this.notes = const [],
    this.isAddingNew = false,
    this.isEditTitle = false,
    this.isEditDescription = false,
  });

  NotesManagerState copyWith({
    List<Note>? notes,
    bool? isAddingNew,
    bool? isEditTitle,
    bool? isEditDescription,
  }) {
    return NotesManagerState(
      notes: notes ?? this.notes,
      isAddingNew: isAddingNew ?? this.isAddingNew,
      isEditTitle: isEditTitle ?? this.isEditTitle,
      isEditDescription: isEditDescription ?? this.isEditDescription,
    );
  }
}
