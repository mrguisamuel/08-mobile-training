import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Record {
  final int points;
  final String time;
  
  Record({
    required this.points,
    required this.time
  });

  factory Record.fromMap(Map<String, dynamic> map) => Record(
    points: map['points'],
    time: map['time']
  );

  Map<String, dynamic> toMap() => {
    'points': this.points,
    'time': this.time
  };
}

class MyDatabase {
  MyDatabase._();
  static final MyDatabase instance = MyDatabase._();
  static Database? _database;
  static const databaseName = 'labyrinth';
  
  Future<Database?> get database async {
    if(_database != null) return _database;

    return await openDatabase(
      join(await getDatabasesPath(), databaseName + '.db'),
      version: 1,
      onCreate: (db, version) async => db.create(
        '''
        CREATE TABLE records(
          id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
          time TEXT NOT NULL,
          points INTEGER NOT NULL
        );
        '''
      )
    );
  }

  static Future<void> insertRecord(Record record) {
    final db = await instance.database;
    await db.insert('records', record.toMap());
  }

  static Future<List<Record>> getAllRecords() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> queryResult = await db.query(
      'SELECT * FROM record ORDER BY points DESC'
    );
    List<Record> records = queryResult.isNotEmpty ?
    queryResult.map((element) => Record.fromMap(element)).toList() : [];
    return records;
  }
}