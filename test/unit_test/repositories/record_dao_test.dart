import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:xpensr/core/constants/record.dart';
import 'package:xpensr/core/dto/record_dto.dart';

import 'package:xpensr/datasources/sqlite_database.dart';
import 'package:xpensr/repositories/record_dao.dart';

/// Ref:
/// https://stackoverflow.com/questions/71136324/writing-unit-tests-for-sqflite-for-flutter
/// https://github.com/tekartik/sqflite/blob/master/sqflite_common_ffi/doc/testing.md
Future main() async {
  Database? db;
  RecordDao? dao;
  int? testId;

  setUpAll(() async {
    // Initialize FFI
    sqfliteFfiInit();
    // Change the default factory
    databaseFactory = databaseFactoryFfi;

    final SQLiteDatabase dbManager = SQLiteDatabase();
    await dbManager.initialize(dbPath: inMemoryDatabasePath);
    db = await dbManager.db;
    dao = RecordDao(db: db!);
  });

  tearDownAll(() async {
    if (db != null) {
      await db!.close();
    }
  });

  group("Unit tests, Record Dao test", () {
    test("RecordDto should be insert", () async {
      expect(dao != null, true);

      RecordDto recordDto = RecordDto.twd(
        amount: 100,
        type: RecordType.shopping,
        title: "Test buy",
        date: DateTime(2025, 1, 1),
      );

      var createdDto = await dao!.insert(recordDto);

      // Id need to be updated
      expect(createdDto.id, greaterThan(0));

      // this id will pass down for other test
      testId = createdDto.id!;
    });

    test("RecordDto should be get", () async {
      expect(dao != null, true);
      expect(testId != null, true);

      // get new created dto
      var dtoGetFromDB = await dao!.getById(testId!);

      expect(dtoGetFromDB != null, true);
    });

    test("RecordDto should be update correctly", () async {
      expect(dao != null, true);
      expect(testId != null, true);

      // get new created dto
      var dtoGetFromDB = await dao!.getById(testId!);

      expect(dtoGetFromDB != null, true);

      var modifyDto = RecordDto.fromMap(dtoGetFromDB!.toMap());
      modifyDto.amount = 101;

      // sql need at least 1 second diffrent to update CURRENT_TIMESTAMP

      await Future.delayed(Duration(seconds: 1));
      await dao!.update(modifyDto);

      var updatedDto = await dao!.getById(testId!);
      expect(updatedDto!.amount, -101); // -101 because expense
      expect(updatedDto.createdAt == dtoGetFromDB.createdAt, true);

      expect(updatedDto.updatedAt == dtoGetFromDB.updatedAt, false);
    });

    test("RecordDto should be soft deleted successfully", () async {
      expect(dao != null, true);
      expect(testId != null, true);

      // get new created dto
      var dtoGetFromDB = await dao!.getById(testId!);

      expect(dtoGetFromDB != null, true);
      expect(dtoGetFromDB!.deletedAt == null, true);

      await dao!.softDelete(testId!);

      var softDeletedDto = await dao!.getById(testId!);

      expect(softDeletedDto != null, true);

      expect(softDeletedDto!.deletedAt == null, false);
    });

    test("RecordDto should be hard deleted successfully", () async {
      expect(dao != null, true);
      expect(testId != null, true);

      // get new created dto
      var dtoGetFromDB = await dao!.getById(testId!);

      expect(dtoGetFromDB != null, true);

      await dao!.hardDelete(testId!);

      var hardDeletedDto = await dao!.getById(testId!);

      expect(hardDeletedDto == null, true);
    });

    group("Get all", () {
      setUpAll(() async {
        // Insert sample records for all tests in this group
        final records = [
          RecordDto.twd(
            amount: 100,
            type: RecordType.shopping,
            title: "Shopping 1",
            date: DateTime(2025, 1, 1),
          ),
          RecordDto.twd(
            amount: 200,
            type: RecordType.shopping,
            title: "Shopping 2",
            date: DateTime(2025, 1, 1),
          ),
          RecordDto.twd(
            amount: 150,
            type: RecordType.dining,
            title: "Food 1",
            date: DateTime(2025, 1, 1),
          ),
          RecordDto.twd(
            amount: 300,
            type: RecordType.entertainment,
            title: "Entertainment 1",
            date: DateTime(2025, 1, 1),
          ),
        ];

        for (var record in records) {
          await dao!.insert(record);
        }
      });

      tearDownAll(() async {
        // Clean up all inserted records after the tests
        var allRecords = await dao!.getAll();
        for (var record in allRecords) {
          await dao!.hardDelete(record.id!);
        }
      });

      test("Should retrieve all records", () async {
        var allRecords = await dao!.getAll();
        expect(allRecords.length, 4);
        expect(
            allRecords.map((e) => e.title).toList(),
            containsAll(
                ["Shopping 1", "Shopping 2", "Food 1", "Entertainment 1"]));
      });

      test("Should limit and offset records correctly", () async {
        var limitedRecords = await dao!.getAll(limit: 2, offset: 1);
        expect(limitedRecords.length, 2);
        expect(
            limitedRecords[0].title, "Shopping 2"); // Offset applied correctly
        expect(limitedRecords[1].title, "Food 1");
      });

      test("Should sort records by amount ASC", () async {
        var sortedByAmountAsc = await dao!.getAll(orderBy: "amount ASC");

        expect(sortedByAmountAsc.first.amount, -100); // Smallest amount first
        expect(sortedByAmountAsc.last.amount, -300); // Largest amount last
      });

      test("Should sort records by amount DESC", () async {
        var sortedByAmountDesc = await dao!.getAll(orderBy: "amount DESC");

        expect(sortedByAmountDesc.first.amount, -300); // Largest amount first
        expect(sortedByAmountDesc.last.amount, -100); // Smallest amount last
      });

      test("Should filter records by date range", () async {
        final now = DateTime.now();
        var filteredByDate = await dao!.getAll(
          startDate:
              now.subtract(Duration(days: 1)), // Should include all records
          endDate: now.add(Duration(days: 1)), // Should include all records
        );
        expect(filteredByDate.length, 4);
      });
    });
  });
}
