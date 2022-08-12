import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "persons.db";
  static final _databaseVersion = 1;

  static final tabel = "my_table";

  static final columnId = "id";
  static final columnName = "name";
  static final columnAge = "age";

  static Database? _database;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tabel(
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnAge INTEGER NOT NULL
      )
''');
  }

  // function to insert, update, delete

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tabel, row);
  }

  // quary

  Future<List<Map<String, dynamic>>> quaryall() async {
    Database db = await instance.database;
    return await db.query(tabel);
  }

  // query specific

  Future<List<Map<String, dynamic>>> queryspecific(int age) async {
    Database db = await instance.database;
    var res = await db.query(tabel, where: "age > ?", whereArgs: [age]);
    //var res = await db.query('SELECT * FROM my_tabel WHERE age > ?' whereArgs: [age]);
    return res;
  }

  // update date

  Future<int> update(int id) async {
    Database db = await instance.database;
    var res = await db.update(tabel, {"name": "Ko Ko", "age": 45},
        where: "id = ?", whereArgs: [id]);
    return res;
  }

  // delete data

  Future<int> deletedata(int id) async {
    Database db = await instance.database;
    var res = await db.delete(tabel, where: "id = ?", whereArgs: [id]);
    return res;
  }
}
