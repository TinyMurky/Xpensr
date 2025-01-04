import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Ref:
/// https://nyonggodwill11.medium.com/flutter-sqflite-323c035dcffe
/// Usage:
/// Use [SQLiteDatabase] () to get singleton
/// use singleton. [initialize] to set up database path
class SQLiteDatabase {
  // internal is the constructor for class internal used
  SQLiteDatabase.internal();
  static final SQLiteDatabase _instance = SQLiteDatabase.internal();
  factory SQLiteDatabase() => _instance; // Database() always return _instance

  final int _sqliteVersion = 3;

  Database? _db; // db is singleton too

  String? _dbPath; // Database path

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  /// Initialize the database with a custom path or default to application directory
  Future<void> initialize({String? dbPath}) async {
    if (_dbPath == null) {
      if (dbPath != null) {
        _dbPath = dbPath;
      } else {
        // getApplicationDocumentsDirectory is place user can edit data, it will be removed after app deleted
        Directory directory = await getApplicationDocumentsDirectory();
        _dbPath = join(directory.path, 'xpensrSQLite.db');
      }
    }
  }

  /// [dbPath] : can set where database is store, use application documentory if not provided
  Future<Database> initDb() async {
    if (_dbPath == null) {
      throw Exception(
          "Database path is not initialized. Call `await initialize` first.");
    }

    // DATETIME
    Database openedDb = await openDatabase(
      _dbPath!,
      version: _sqliteVersion,
      onCreate: (Database db, int version) async {
        await db.execute("""
          CREATE TABLE record (
            id INTEGER PRIMARY KEY,
            amount DOUBLE NOT NULL,
            title TEXT NOT NULL,
            currency CHAR(3) NOT NULL,
            exchange_rate DOUBLE NOT NULL,
            system_base_currency CHAR(3) NOT NULL,
            type CHAR(50) NOT NULL,
            date DATETIME NOT NULL,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
            updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
            deleted_at DATETIME DEFAULT NULL
          );

          -- Add Default update updated_at -- 

          CREATE TRIGGER update_updated_at
          AFTER UPDATE on record
          FOR EACH ROW
          BEGIN
            UPDATE record
            SET updated_at = CURRENT_TIMESTAMP
            WHERE id = OLD.id;
          END;
          """);
      },
      // there is onUpgrade, onDowngrade to used
    );
    return openedDb;
  }
}
