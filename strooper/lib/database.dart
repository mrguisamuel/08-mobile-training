import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Record {
  final int points;
  final double averageReactionTime;
  final double averageCorrectWords;

  Record({
    required this.points,
    required this.averageReactionTime,
    required this.averageCorrectWords
  });

  factory Record.fromMap(Map<String, dynamic> data) => new Record(
    points: data['points'],
    averageReactionTime: data['averageReactionTime'],
    averageCorrectWords: data['averageCorrectWords'],
  );

  Map<String, dynamic> toMap() {
    return {
      'points': this.points,
      'averageReactionTime': this.averageReactionTime,
      'averageCorrectWords': this.averageCorrectWords,
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
    print('Database was created!');
    return await openDatabase(
      join(databasePath, databaseName + '.db'),
      onCreate: (database, version) async {
        await database.execute(  
          '''
          CREATE TABLE record(
            id INTEGER NOT NULL PRIMART KEY AUTOINCREMENT,
            points INTEGER NOT NULL,
            averageReactionTime REAL NOT NULL,
            averageCorrectWords REAL NOT NULL
          );
          '''
        );
      },
      version: 1
    );
  }

  Future<int> insertRecord(Record record) async {
    Database db = await instance.database;
    return await db.insert('record', record.toMap());
  }

  Future<List<Record>> getAllRecords() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> query = await db.query('record');
    List<Record> records = query.isNotEmpty ?
    query.map((r) => Record.fromMap(r)).toList() : [];
    return records;
  }

  Future<void> dispose() async {
    Database db = await instance.database;
    db.close();
  }
}