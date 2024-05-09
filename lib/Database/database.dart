
import 'package:sqflite/sqflite.dart';

late Database db;
Future<void> initDatabase() async {
  db = await openDatabase(
    'student.db',
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, roll_no INTEGER)');
    },
  );
}

