import 'package:b8/models/Product.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // Tạo 1 instance singleton của DatabaseHelper
  static final DatabaseHelper instance = DatabaseHelper._init();

  // Khai báo biến _database để giữ instance của CSDL
  static Database? _database;

  // Khởi tạo 1 init
  DatabaseHelper._init();

  // Hàm getter bất đồng bộ để lấy instance của CSDL
  Future<Database> get database async {
    if (_database == null) {
      _database = await _initDB('productdb.db');
    }
    return _database!;
  }

  // Hàm này là để khởi tạo db
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createTB);
  }

  // Hàm để tạo bảng trong CSDL
  Future _createTB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        category TEXT NOT NULL,
        isAvailable BOOLEAN NOT NULL,
        condition TEXT NOT NULL
      )
    ''');
  }

  // Truy vấn tất cả danh sách từ bảng products
  Future<List<Product>> getAllProducts() async {
    final db = await instance.database;
    final result = await db.query('products');

    // Chuyển đổi kết quả truy vấn thành danh sách các đối tượng Product
    return result.map((json) => Product.fromJson(json)).toList();
  }

  // Tạo method create
  Future<int> createProduct(Product product) async {
    final db = await instance.database;
    final result = await db.insert('products', product.toMap());
    return result;
  }

  // Tạo method update
  Future<int> updateProduct(Product product) async {
    final db = await instance.database;
    final result = await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
    return result;
  }

  // Tạo method delete
  Future<int> deleteProduct(int id) async {
    final db = await instance.database;
    final result = await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result;
  }

  // Tạo method sắp xếp sản phẩm theo tên
  Future<List<Product>> sortProductsByName() async {
    final db = await instance.database;
    final result = await db.query(
      'products',
      orderBy: 'name ASC',
    );

    return result.map((json) => Product.fromJson(json)).toList();
  }

  // Tạo method tìm kiếm sản phẩm theo tên
  Future<List<Product>> searchProductsByName(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'products',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );

    return result.map((json) => Product.fromJson(json)).toList();
  }
}
