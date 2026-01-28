import 'package:sqflite/sqflite.dart';
import '../../data/models/user_jellycat_model.dart';
import '../../../../services/database/database_schema.dart';
import '../../../../services/database/sqlite_service.dart';

/// Local data source for user's Jellycat collection
abstract class UserCollectionLocalDataSource {
  Future<List<String>> getAllJellycatIds();
  Future<bool> isInCollection(String jellycatId);
  Future<void> add(String jellycatId);
  Future<void> remove(String jellycatId);
}

class UserCollectionLocalDataSourceImpl
    implements UserCollectionLocalDataSource {
  final DatabaseService databaseService;

  UserCollectionLocalDataSourceImpl({required this.databaseService});

  @override
  Future<List<String>> getAllJellycatIds() async {
    final db = await databaseService.database;
    final maps = await db.query(
      DatabaseSchema.tableUserCollection,
      columns: ['jellycat_id'],
    );
    return maps.map((map) => map['jellycat_id'] as String).toList();
  }

  @override
  Future<bool> isInCollection(String jellycatId) async {
    final db = await databaseService.database;
    final maps = await db.query(
      DatabaseSchema.tableUserCollection,
      where: 'jellycat_id = ?',
      whereArgs: [jellycatId],
      limit: 1,
    );
    return maps.isNotEmpty;
  }

  @override
  Future<void> add(String jellycatId) async {
    final db = await databaseService.database;
    await db.insert(
      DatabaseSchema.tableUserCollection,
      {
        'jellycat_id': jellycatId,
        'date_acquired': DateTime.now().toIso8601String(),
        'condition': 'Mint',
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> remove(String jellycatId) async {
    final db = await databaseService.database;
    await db.delete(
      DatabaseSchema.tableUserCollection,
      where: 'jellycat_id = ?',
      whereArgs: [jellycatId],
    );
  }
}
