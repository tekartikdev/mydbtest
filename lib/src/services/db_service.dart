import 'dart:io';

import 'package:flutter/services.dart';
import 'package:mydbtest/src/models/palibook.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  late Database _db;
  Future? _dbInit;

  Future initDatabase() async {
    _dbInit ??= await () async {
      _db = await openDatabase('assets/1101.sqlite3');
      var databasePath = await getDatabasesPath();
      var path = join(databasePath, '1101.sqlite3');

      //Check if DB exists
      var exists = await databaseExists(path);

      if (!exists) {
        print('Create a new copy from assets');

        //Check if parent directory exists
        try {
          await Directory(dirname(path)).create(recursive: true);
        } catch (_) {}

        //Copy from assets
        ByteData data = await rootBundle.load(join("assets", "1101.sqlite3"));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

        //Write and flush the bytes
        await File(path).writeAsBytes(bytes, flush: true);
      }

      //Open the database
      _db = await openDatabase(path, readOnly: true);
    }();
  }

  Future<List<PaliBook>> getPali() async {
    await initDatabase();
    List<Map> list = await _db.rawQuery('Select id, P_HTM from pali');
    return list.map((palibook) => PaliBook.fromJson(palibook)).toList();
    //return list.map((trail) => Trail.fromJson(trail)).toList();
  }

  dispose() {
    _db.close();
  }
}
