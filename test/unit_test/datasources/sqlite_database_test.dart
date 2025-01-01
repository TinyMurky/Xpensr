import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:xpensr/datasources/sqlite_database.dart';

/// Ref:
/// https://stackoverflow.com/questions/71136324/writing-unit-tests-for-sqflite-for-flutter
/// https://github.com/tekartik/sqflite/blob/master/sqflite_common_ffi/doc/testing.md
Future main() async {
  setUpAll(() {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;
  });

  group("Unit tests, SQLite database test", () {
    test("SQLite should be init", () async {
      final SQLiteDatabase dbManager = SQLiteDatabase();
      await dbManager.initialize(dbPath: inMemoryDatabasePath);
      Database? db = await dbManager.db;

      bool isDatabase = db is Database;
      expect(isDatabase, true);

      expect(db!.isOpen, true);

      await db.close();
    });
  });
}
