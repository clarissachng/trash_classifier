import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categories (
        category_id INTEGER PRIMARY KEY,
        category_name TEXT,
        quantity INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE scanned_items (
        id INTEGER PRIMARY KEY,
        item_name TEXT,
        scan_date TEXT,
        category_id INTEGER,
        FOREIGN KEY (category_id) REFERENCES categories(category_id)
      )
    ''');
  }

  Future<int> insertScannedItem(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('scanned_items', row);
  }

  Future<int> updateQuantity(int categoryId) async {
    Database db = await database;
    return await db.rawUpdate('''
      UPDATE categories
      SET quantity = quantity + 1
      WHERE category_id = ?
    ''', [categoryId]);
  }

  Future<List<Map<String, dynamic>>> fetchAllScannedItems() async {
    Database db = await database;
    return await db.query('scanned_items');
  }

  Future<List<Map<String, dynamic>>> fetchAllCategories() async {
    Database db = await database;
    return await db.query('categories');
  }
}
