import 'dart:io';
import 'package:async/async.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {

  static final DBProvider _instance = DBProvider._private();
  DBProvider._private();

  factory DBProvider() => _instance;

  static Database _database;
  final _initDBMemoizer = AsyncMemoizer<Database>();

  Future<Database> get database async {
    if (_database != null)
      return _database;

    _database = await _initDBMemoizer.runOnce(() async {
      return await _setup();
    });

    return _database;
  }

  _setup() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = p.join(documentsDirectory.path, "test.db");
    return await openDatabase(path, version: 1,
      onOpen: openDB,
      onUpgrade: upgradeDB,
      onCreate: initDB
    );
  }

  void openDB(Database db) async {

  }

  void upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) { }
  }

  void initDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE $tableLogs(
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnLevel INTEGER NOT NULL,
    $columnMessage TEXT NOT NULL,
    $columnTimestamp INTEGER NOT NULL
);
''');
  }

  static const String tableLogs = 'logs';
  static const String columnId = 'id';
  static const String columnLevel = 'level';
  static const String columnMessage = 'message';
  static const String columnTimestamp = 'timestamp';

  Future<List<Map<String, dynamic>>> getLogs() async {
    final db = await database;
    var res = await db.query(tableLogs);
    return res.isNotEmpty ? res.toList() : [];
  }

  Future<int> insertLog(int level, String message, int timestamp) async {
    final db = await database;
    return await db.insert(tableLogs, {
      columnLevel: level,
      columnMessage: message,
      columnTimestamp: timestamp,
    });
  }
}