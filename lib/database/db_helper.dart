import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/note.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2, // ĐÃ TĂNG VERSION LÊN 2
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    print('ℹ️ Creating new database version $version...'); // LOG
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE notes (
        id $idType,
        title $textType,
        content $textType,
        createdAt $textType,
        updatedAt $textType
      )
    ''');
    print('✅ Table notes created successfully.'); // LOG
  }

  // CREATE
  Future<int> create(Note note) async {
    final db = await database;
    final id = await db.insert('notes', note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    print('✅ Note created with ID: $id. Title: ${note.title}'); // LOG
    return id;
  }

  // READ ALL
  Future<List<Note>> readAll() async {
    final db = await database;
    final maps = await db.query('notes', orderBy: 'updatedAt DESC');
    print('🔍 Found ${maps.length} records in DB.'); // LOG

    return maps.map((json) => Note.fromMap(json)).toList();
  }

  // UPDATE và DELETE không thay đổi
  Future<int> update(Note note) async {
    final db = await database;
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}