import 'package:sqflite/sqflite.dart';
import '../../../../services/database/database_schema.dart';
import '../../../../services/database/sqlite_service.dart';

/// Local data source for wishlist
abstract class WishlistLocalDataSource {
  Future<List<String>> getAllJellycatIds();
  Future<bool> isInWishlist(String jellycatId);
  Future<void> add(String jellycatId);
  Future<void> remove(String jellycatId);
}

class WishlistLocalDataSourceImpl implements WishlistLocalDataSource {
  final DatabaseService databaseService;

  WishlistLocalDataSourceImpl({required this.databaseService});

  @override
  Future<List<String>> getAllJellycatIds() async {
    final db = await databaseService.database;
    final maps = await db.query(
      DatabaseSchema.tableWishlist,
      columns: ['jellycat_id'],
      orderBy: 'priority ASC, date_added DESC',
    );
    return maps.map((map) => map['jellycat_id'] as String).toList();
  }

  @override
  Future<bool> isInWishlist(String jellycatId) async {
    final db = await databaseService.database;
    final maps = await db.query(
      DatabaseSchema.tableWishlist,
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
      DatabaseSchema.tableWishlist,
      {
        'jellycat_id': jellycatId,
        'date_added': DateTime.now().toIso8601String(),
        'priority': 5,
        'notes': null,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> remove(String jellycatId) async {
    final db = await databaseService.database;
    await db.delete(
      DatabaseSchema.tableWishlist,
      where: 'jellycat_id = ?',
      whereArgs: [jellycatId],
    );
  }
}
