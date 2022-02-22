import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbController {
  static final DbController _dbControllerObj =
      DbController._dbControllerConstructor();

  late Database _databaseLibObj;

  DbController._dbControllerConstructor();

  Database get getDatabase => _databaseLibObj;

      factory DbController() {
    return _dbControllerObj;
  }

  Future<void> initDatabase() async {
    Directory dbDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dbDirectory.path, 'app_db.sql');
    _databaseLibObj = await openDatabase(
      dbPath,
      version: 1,
      onOpen: (Database db) {},
      onCreate: (Database db, int version) async{
        await db.execute('CREATE TABLE contacts('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'name TEXT NOT NULL,'
            'phone TEXT NOT NULL'
            ')');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {},
      onDowngrade: (Database db, int oldVersion, int newVersion) {},
    );
  }
}
