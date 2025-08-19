import 'package:scotti_seguros/models/notes_manager/notes_manager.dart';

class NotesManagerState {
  final List<Note> notes;
  final bool isAddingNew;

  const NotesManagerState({
    this.notes = const [],
    this.isAddingNew = false,
  });

  NotesManagerState copyWith({
    List<Note>? notes,
    bool? isAddingNew,
  }) {
    return NotesManagerState(
      notes: notes ?? this.notes,
      isAddingNew: isAddingNew ?? this.isAddingNew,
    );
  }
}
