import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master.db");
    final database = await openDatabase(
      databasePath,
      version: 1, // Specify the version here
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE schedules (
            date INTEGER PRIMARY KEY,
            tasks TEXT NOT NULL
          )
        ''');
      },
    );
    return database;
  }

  Future<bool> addSchedule(int date, String content) async {
    final db = await database;
    int result = await db.insert(
      'schedules',
      {
        'date': date,
        'tasks': content,
      },
    );
    return result > 0;
  }

  Future<String> getSchedule(int date) async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query(
      'schedules',
      where: 'date = ?',
      whereArgs: [date],
    );

    if (data.isNotEmpty) {
      return data.first['tasks'] as String;
    } else {
      return 'No data found for provided date';
    }
  }

  Future<int> deleteSchedule(int date) async {
    final db = await database;
    return await db.delete(
      'schedules',
      where: 'date = ?',
      whereArgs: [date],
    );
  }
}
