import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'product.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'ProductDB.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE Product(id INTEGER PRIMARY KEY AUTOINCREMENT, product_name TEXT, price DOUBLE, quantity INTEGER)",
        );
      },
    );
  }

  Future<void> insertProduct(Product product) async {
    final db = await database;
    await db.insert('Product', product.toMap());
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('Product');

    return List.generate(maps.length, (i) {
      return Product(
        id: maps[i]['id'],
        productName: maps[i]['product_name'],
        price: maps[i]['price'],
        quantity: maps[i]['quantity'],
      );
    });
  }

  Future<void> updateProduct(Product product) async {
    final db = await database;
    await db.update(
      'Product',
      product.toMap(),
      where: "id = ?",
      whereArgs: [product.id],
    );
  }

  Future<List<Product>> getProductsSortedByPrice(
      {bool ascending = true}) async {
    final db = await database;
    final orderBy = ascending ? 'ASC' : 'DESC';
    final List<Map<String, dynamic>> maps = await db.query(
      'Product',
      orderBy: 'price $orderBy',
    );

    return List.generate(maps.length, (i) {
      return Product(
        id: maps[i]['id'],
        productName: maps[i]['product_name'],
        price: maps[i]['price'],
        quantity: maps[i]['quantity'],
      );
    });
  }
}
