import 'package:notinhas_app/database/dao/notes_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = await getDatabasesPath();
  final String path = join(dbPath, 'notinhas.db');
  return await openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(NotesDao.tableSql);
    },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete,
  );
}
