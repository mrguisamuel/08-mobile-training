import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Record {
  final int points;
  final double averageReactTime;
  final double averageCorrectWords;
  final int isDefaultGame;

  Record({
    required this.points,
    required this.averageReactTime,
    required this.averageCorrectWords,
    required this.isDefaultGame
  });

  factory Record.fromMap(Map<String, dynamic> data) => new Record(
    points: data['points'],
    averageReactTime: data['averageReactTime'],
    averageCorrectWords: data['averageCorrectWords'],
    isDefaultGame: data['isDefaultGame']
  );

  Map<String, dynamic> toMap() {
    return {
      'points': this.points,
      'averageReactTime': this.averageReactTime,
      'averageCorrectWords': this.averageCorrectWords,
      'isDefaultGame': this.isDefaultGame
    };
  }
}

class MyDatabase {
  MyDatabase._();
  static final MyDatabase instance = MyDatabase._();
  static String databaseName = 'strooper';

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    String databasePath = await getDatabasesPath();
    return await openDatabase(
      join(databasePath, databaseName + '.db'),
      onCreate: (database, version) async {
        await database.execute(
          '''
          CREATE TABLE record(
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            points INTEGER NOT NULL,
            averageReactTime REAL NOT NULL,
            averageCorrectWords REAL NOT NULL,
            isDefaultGame INTEGER NOT NULL
          );
          '''
        );
      },
      version: 1
    );
    print('Database was created!');
  }

  Future<int> insertRecord(Record record) async {
    Database db = await instance.database;
    return await db.insert('record', record.toMap());
  }

  Future<List<Record>> getAllRecords() async {
    Database db = await instance.database;
    //List<Map<String, dynamic>> query = await db.query('record');
    List<Map<String, dynamic>> query = await db.rawQuery(
      'SELECT * FROM record ORDER BY points ASC'
    );
    List<Record> records = query.isNotEmpty ?
    query.map((r) => Record.fromMap(r)).toList() : [];
    return records;
  }

  Future<void> dispose() async {
    Database db = await instance.database;
    db.close();
  }
}