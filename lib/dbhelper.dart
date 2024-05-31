import 'reminder.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class dbhelper{
  static final dbhelper instance = dbhelper.internal();
  factory dbhelper() => instance;
  dbhelper.internal();
  static Database? _database;

  Future<Database> get database async{
    if(_database != null)
      return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'reminder.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('CREATE TABLE reminders(uid INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, datetime TEXT)'
        );
      },
    );
  }

  Future<void> insert(reminder _reminder)async{
    final db = await database;
    await db.insert('reminders', _reminder.tomap(),
    conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  Future<List<reminder>> getreminders() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reminders');
    return List.generate(maps.length, (i) {
      return reminder.fromMap(maps[i]);
    });
  }

  Future<void> delete(int? uid) async {
    final db = await database;
    await db.delete(
      'reminders',
      where: "uid = ?",
      whereArgs: [uid],
    );
  }

  Future<void> update(reminder _reminder) async {
    final db = await database;
    await db.update(
      'reminders',
      _reminder.tomap(),
      where: "uid = ?",
      whereArgs: [_reminder.uid],
    );
  }

}