import 'package:sqflite/sqflite.dart';
import '../../data/models/jellycat_model.dart';
import '../../../../services/database/database_schema.dart';
import '../../../../services/database/sqlite_service.dart';

/// Local data source for Jellycat catalog using SQLite
abstract class JellycatLocalDataSource {
  Future<List<JellycatModel>> getAll();
  Future<JellycatModel?> getById(String id);
  Future<List<JellycatModel>> getByCollection(String collectionName);
  Future<List<String>> getAllCollections();
  Future<void> saveAll(List<JellycatModel>> jellycats);
  Future<void> save(JellycatModel jellycat);
}

class JellycatLocalDataSourceImpl implements JellycatLocalDataSource {
  final DatabaseService databaseService;

  JellycatLocalDataSourceImpl({required this.databaseService});

  @override
  Future<List<JellycatModel>> getAll() async {
    final db = await databaseService.database;
    final maps = await db.query(DatabaseSchema.tableJellycats);
    return maps.map((map) => JellycatModel.fromSqlite(map)).toList();
  }

  @override
  Future<JellycatModel?> getById(String id) async {
    final db = await databaseService.database;
    final maps = await db.query(
      DatabaseSchema.tableJellycats,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) return null;
    return JellycatModel.fromSqlite(maps.first);
  }

  @override
  Future<List<JellycatModel>> getByCollection(String collectionName) async {
    final db = await databaseService.database;
    final maps = await db.query(
      DatabaseSchema.tableJellycats,
      where: 'collection_name = ?',
      whereArgs: [collectionName],
    );
    return maps.map((map) => JellycatModel.fromSqlite(map)).toList();
  }

  @override
  Future<List<String>> getAllCollections() async {
    final db = await databaseService.database;
    final maps = await db.query(
      DatabaseSchema.tableJellycats,
      distinct: true,
      columns: ['collection_name'],
      orderBy: 'collection_name ASC',
    );
    return maps
        .map((map) => map['collection_name'] as String)
        .where((name) => name.isNotEmpty)
        .toList();
  }

  @override
  Future<void> saveAll(List<JellycatModel> jellycats) async {
    final db = await databaseService.database;
    final batch = db.batch();

    for (final jellycat in jellycats) {
      batch.insert(
        DatabaseSchema.tableJellycats,
        jellycat.toSqlite(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
  }

  @override
  Future<void> save(JellycatModel jellycat) async {
    final db = await databaseService.database;
    await db.insert(
      DatabaseSchema.tableJellycats,
      jellycat.toSqlite(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
