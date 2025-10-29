import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/word.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('words.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE words(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        term TEXT NOT NULL,
        translation TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertWord(Word word) async {
    final db = await database;
    return await db.insert('words', word.toMap());
  }

  Future<List<Word>> getWords() async {
    final db = await database;
    final maps = await db.query('words', orderBy: 'term ASC');
    return maps.map((m) => Word.fromMap(m)).toList();
  }

  Future<int> updateWord(Word word) async {
    final db = await database;
    return await db.update('words', word.toMap(), where: 'id = ?', whereArgs: [word.id]);
  }

  Future<int> deleteWord(int id) async {
    final db = await database;
    return await db.delete('words', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
