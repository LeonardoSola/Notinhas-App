import 'package:notinhas_app/models/note.dart';
import 'package:sqflite/sqflite.dart';

import '../app_databaase.dart';

class NotesDao {
  static const String _tableName = 'notes';
  static const String _id = 'id';
  static const String _title = 'title';
  static const String _content = 'content';
  static const String _color = 'color';
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
      '$_title TEXT, '
      '$_content TEXT,'
      '$_color INTEGER )';

  Future<int> save(Note note) async {
    final Database db = await getDatabase();
    Map<String, dynamic> noteMap = _toMap(note);
    return db.insert(_tableName, noteMap);
  }

  Future<List<Note>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    List<Note> notes = _toList(result);
    return notes;
  }

  Future<Note> find(id) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(
        _tableName,
        where: '$_id = ?',
        whereArgs: [id]);
    List<Note> note = _toList(result);
    return note[0];
  }


  Map<String, dynamic> _toMap(Note note) {
    final Map<String, dynamic> noteMap = {
      'title': note.title,
      'content': note.content,
      'color': note.getColor(),
    };
    return noteMap;
  }

  List<Note> _toList(List<Map<String, dynamic>> result) {
    final List<Note> notes = [];
    for (Map<String, dynamic> row in result) {
      final Note note = Note(
        row['id'],
        row['content'],
        row['color'],
        title: row['title'],
      );
      notes.add(note);
    }
    return notes;
  }

  Future<int> update(int id, String content, String title, int color) async {
    final Database db = await getDatabase();
    db.rawQuery(
      'UPDATE $_tableName SET content = \'${content.replaceAll("'", '"')}\', title = \'${title.replaceAll("'", '"')}\', color = \'${color}\' WHERE id = $id'
    );
    return 1;
  }

  Future<int> delete(id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: '$_id = ?',
      whereArgs: [id],
    );
  }
}
