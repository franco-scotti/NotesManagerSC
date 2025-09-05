import 'package:scotti_seguros/database/db.dart';
import 'package:scotti_seguros/models/notes_manager/notes_manager.dart';

class NotesManagerRepository {
  Future<int> addNote(Note note) async {
    try {
      final db = await Db.instance.database;
      return await db.insert('note', note.toMap());
    } catch (e) {
      return 0;
    }
  }

  Future<List<Note>> getAllNotes() async {
    final db = await Db.instance.database;
    final result = await db.query('note');
    return result.map((map) => Note.fromMap(map)).toList();
  }

  Future<int> updateNote(Note note) async {
    final db = await Db.instance.database;
    return await db.update(
      'note',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await Db.instance.database;
    return await db.delete(
      'note',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
