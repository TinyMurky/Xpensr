import 'package:sqflite/sqflite.dart';

import 'package:xpensr/core/dto/record_dto.dart';

class RecordDao {
  final Database db;

  final String _table = 'record';

  RecordDao({required this.db});

  /// insert 1 record by [RecordDto]
  /// return [RecordDto] with id, but no createAt, updatedAt, deletedAt
  Future<RecordDto> insert(RecordDto recordDto) async {
    recordDto.id = await db.insert(
      _table,
      recordDto.toMap(),
    );
    return recordDto;
  }

  /// use [id] to get [RecordDto]
  /// get first [RecordDto] if found
  /// it might return null if not found
  Future<RecordDto?> getById(int id) async {
    List<Map<String, Object?>> maps = await db.query(
      _table,
      // use below if only want some columns
      // columns: [id, amount]
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return RecordDto.fromMap(maps.first);
    }

    return null;
  }

  /// [limit] : how many item that can contain in list max return
  /// [offset] : escape [offset] items
  /// [orderBy] : "created_at DESC" or "amount ASC" or "created_at DESC AND amount ASC"。
  /// [startDate] : createdAt >= [startDate]
  /// [endDate] : updatedAt <= [endDate]
  Future<List<RecordDto>> getAll({
    int? limit,
    int? offset,
    String? orderBy,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    /// [whereClauses] contain all "where" condition then join by "AND"
    final whereClauses = <String>['deleted_at IS NULL'];

    /// [whereArgs] will filled all "?" in [whereClauses]
    final whereArgs = <String>[];

    if (startDate != null) {
      whereClauses.add("created_at >= ?");
      whereArgs.add(startDate.toIso8601String());
    }

    if (endDate != null) {
      whereClauses.add("created_at <= ?");
      whereArgs.add(endDate.toIso8601String());
    }

    List<Map<String, Object?>> maps = await db.query(
      _table,
      where: whereClauses.join(" AND "),
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
      offset: offset,
    );

    return maps.map((map) => RecordDto.fromMap(map)).toList();
  }

  /// Argument recordDto must have id
  /// will return the target id
  Future<int> update(RecordDto recordDto) async {
    if (recordDto.id == null) {
      throw ArgumentError(
          "When update record in database, id must be provied in RecordDto");
    }

    return await db.update(
      _table,
      recordDto.toMap(excludeUpdatedAt: true),
      where: "id = ?",
      whereArgs: [recordDto.id],
    );
  }

  /// Caution!!!
  /// This will actually delete record
  /// please use [softDelete] instead
  /// [id] : target index to be delete
  Future<int> hardDelete(int id) async {
    return db.delete(
      _table,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  /// This will only add deleted_at to item
  /// use [hardDelete] if you want to actually remove item
  Future<int> softDelete(int id) async {
    return db.update(
      _table,
      {"deleted_at": DateTime.now().toIso8601String()},
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
