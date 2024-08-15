import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'employee.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  String employeeTable = 'employee_table';
  String colId = 'id';
  String colName = 'name';
  String colGender = 'gender';
  String colSkills = 'skills';

  Future<Database> get db async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'employee.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  void _createDb(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $employeeTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colGender TEXT, $colSkills TEXT)',
    );
  }

  Future<int> insertEmployee(Employee employee) async {
    Database db = await this.db;
    final int result = await db.insert(employeeTable, employee.toMap());
    return result;
  }

  Future<List<Employee>> getEmployeeList() async {
    Database db = await this.db;
    final List<Map<String, dynamic>> employeeMapList =
        await db.query(employeeTable);
    return List.generate(employeeMapList.length, (index) {
      return Employee.fromMap(employeeMapList[index]);
    });
  }

  Future<int> updateEmployee(Employee employee) async {
    Database db = await this.db;
    final int result = await db.update(
      employeeTable,
      employee.toMap(),
      where: '$colId = ?',
      whereArgs: [employee.id],
    );
    return result;
  }

  Future<int> deleteEmployee(int id) async {
    Database db = await this.db;
    final int result = await db.delete(
      employeeTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }
}
