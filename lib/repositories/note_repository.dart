import 'package:notinhas/models/note.dart';
import 'package:sqflite/sqflite.dart';

class NoteRepository {
  static const String _tableName = 'notes';
  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columnContent = 'content';
  static const String columnColorId = 'color';
  static const String columnDate = 'date';

  Database? _database;

  Future<Database> open() async {
    final databasePath = await getDatabasesPath();
    final path = "$databasePath/notes.db";
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE $_tableName (
            $columnId INTEGER PRIMARY KEY,
            $columnTitle TEXT NOT NULL,
            $columnContent TEXT NOT NULL,
            $columnColorId INTEGER NOT NULL,
            $columnDate TEXT NOT NULL
          )
          ''',
        );
      },
    );
  }

  Future<void> close() async {
    final Database db = await database;
    db.close();
  }

  Future<Database> get database async {
    _database ??= await open();
    return _database!;
  }

  Future<int> insert(Note note) async {
    final Database db = await database;
    return db.insert(_tableName, note.toMap());
  }

  Future<Note> get(int id) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      _tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
    return Note.fromMap(maps.first);
  }

  Future<List<Note>> getNotes() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return Note.fromMap(maps[i]);
    });
  }

  Future<void> update(Note note) async {
    final Database db = await database;
    await db.update(
      _tableName,
      note.toMap(),
      where: '$columnId = ?',
      whereArgs: [note.id],
    );
  }

  Future<void> delete(int id) async {
    final Database db = await database;
    await db.delete(
      _tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
