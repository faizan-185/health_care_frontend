import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Log.dart';
class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'logs.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE log(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, datetime TEXT NOT NULL, type TEXT NOT NULL, bill TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertLog(Log log) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('log', log.toMap());
    return result;
  }

  Future<List<Log>> retrieveLogs() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('log', limit: 5, orderBy: "id");
    return queryResult.map((e) => Log.fromMap(e)).toList();
  }
}