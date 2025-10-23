import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ActivationService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'activation.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE activation (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            key_value TEXT
          )
        ''');
      },
    );
  }

  Future<void> saveKey(String key) async {
    final db = await database;
    await db.insert('activation', {'key_value': key});
  }

  Future<String?> getKey() async {
    final db = await database;
    final result = await db.query('activation', limit: 1);
    if (result.isNotEmpty) {
      return result.first['key_value'] as String;
    }
    return null;
  }

  Future<void> clearKey() async {
    final db = await database;
    await db.delete('activation');
  }
}
