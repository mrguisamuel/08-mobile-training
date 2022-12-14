import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/wsa_image.dart';

class MyDatabase {
  MyDatabase._();

  static final MyDatabase instance = MyDatabase._();
  static Database? _database;
  static const databaseName = 'remind_me';

  get database async {
    if(_database != null) return _database;
    return await openDatabase(
      join(await getDatabasesPath(), databaseName + '.db'),
      version: 1,
      onCreate: (db, version) async => db.execute(
        '''
        CREATE TABLE saveimages(
          id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          location TEXT NOT NULL,
          image BLOB NOT NULL,
          audio BLOB NOT NULL,
          time TEXT NOT NULL,
          date TEXT NOT NULL
        );
        '''
      )
    );
  }

  static Future<void> insertImage(WSAImage image) async {
    final db = await instance.database;
    await db.insert('saveimages', image.toMap());
  }

  static Future<List<WSAImage>> getAllImages() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> queryResult = await db.query(
      'saveimages', orderBy: 'id'
    );
    return queryResult.map((element) => WSAImage.fromMap(element)).toList();
  }
}