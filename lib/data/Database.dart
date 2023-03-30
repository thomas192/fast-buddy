import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:fast_buddy/models/Fast.dart';

class FastingDatabase {
  static const String fastingTable = 'fasting';

  static Future<void> initialize() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'fasting_history.db');
    final db = await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        CREATE TABLE $fastingTable (
          id INTEGER PRIMARY KEY,
          start VARCHAR(25),
          end VARCHAR(25)
        )
      ''');
    });

    await db.close();
  }

  static Future<Database> getDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'fasting_history.db');
    return await openDatabase(path, version: 1);
  }

  static Future<int> addStart(DateTime start) async {
    final db = await getDatabase();
    final id = await db.insert(fastingTable, {
      'start': start.toIso8601String(),
      'end': null,
    });

    await db.close();

    return id;
  }

  static Future<bool> addEnd(int id, DateTime end) async {
    final db = await getDatabase();
    int result = await db.update(
      fastingTable,
      {'end': end.toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );

    await db.close();

    return result > 0;
  }


  static Future<List<Fast>> getFasts() async {
    final db = await getDatabase();
    final results = await db.query(
      fastingTable,
      where: 'start IS NOT NULL AND end IS NOT NULL',
    );

    await db.close();

    List<Fast> fastList = [];
    for (Map<String, dynamic> map in results) {
      fastList.add(Fast.fromMap(map));
    }

    return fastList;
  }

  static Future<Fast?> getLatestFast() async {
    final db = await getDatabase();
    final result = await db.rawQuery(
        'SELECT * FROM $fastingTable ORDER BY start DESC LIMIT 1'
    );
    if (result.isNotEmpty) {
      return Fast.fromMap(result.first);
    } else {
      return null;
    }
  }


  static Future<bool> deleteFast(int id) async {
    final db = await getDatabase();
    int result = await db.delete(
      fastingTable,
      where: "id = ?",
      whereArgs: [id],
    );

    return result > 0;
  }

}
