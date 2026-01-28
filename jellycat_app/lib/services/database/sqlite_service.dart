import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'database_schema.dart';

/// SQLite database service for local data persistence
class DatabaseService {
  static Database? _database;
  static final DatabaseService _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  DatabaseService._internal();

  /// Get database instance, creating it if necessary
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize the database
  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, DatabaseSchema.databaseName);

    return await openDatabase(
      path,
      version: DatabaseSchema.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  /// Create database tables
  Future<void> _onCreate(Database db, int version) async {
    // Create all tables
    for (final statement in DatabaseSchema.createTableStatements) {
      await db.execute(statement);
    }

    // Create all indexes
    for (final statement in DatabaseSchema.createIndexStatements) {
      await db.execute(statement);
    }

    // Insert sample data
    await _insertSampleData(db);
  }

  /// Handle database upgrades
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database migrations here
    // For now, we'll just recreate the database
    if (oldVersion < newVersion) {
      // Add migration logic here as the app evolves
    }
  }

  /// Insert sample Jellycat data for demonstration
  Future<void> _insertSampleData(Database db) async {
    final sampleJellycats = [
      {
        'id': 'BASS6BUN',
        'name': 'Bashful Bunny',
        'collection_name': 'Bashful',
        'description': 'A timeless classic with super soft fur and long lop ears',
        'image_url': null,
        'colors': 'Cream,Blush,Hot Pink,Beige',
        'sizes': 'Small,Medium,Large,Huge',
        'current_price': 12.00,
        'released_date': '2010-01-01T00:00:00.000',
        'retired_date': null,
        'is_new': 0,
        'is_retired': 0,
        'is_planned': 0,
        'estimated_quantity': 10000,
      },
      {
        'id': 'BASS6BBLK',
        'name': 'Bashful Black & Cream Puppy',
        'collection_name': 'Bashful',
        'description': 'A floppy-eared pup with waggly tail and squishy paws',
        'image_url': null,
        'colors': 'Black,Cream',
        'sizes': 'Small,Medium,Large',
        'current_price': 15.00,
        'released_date': '2015-06-01T00:00:00.000',
        'retired_date': null,
        'is_new': 0,
        'is_retired': 0,
        'is_planned': 0,
        'estimated_quantity': 5000,
      },
      {
        'id': 'AMUS2AVG',
        'name': 'Amuseable Avocado',
        'collection_name': 'Amuseables',
        'description': 'A happy avocado with squidgy green tummy and brown suedette stone',
        'image_url': null,
        'colors': 'Green,Brown',
        'sizes': 'One Size',
        'current_price': 18.00,
        'released_date': '2018-09-01T00:00:00.000',
        'retired_date': null,
        'is_new': 1,
        'is_retired': 0,
        'is_planned': 0,
        'estimated_quantity': 8000,
      },
      {
        'id': 'AMUS2RSTW',
        'name': 'Amuseable Strawberry',
        'collection_name': 'Amuseables',
        'description': 'A berry sweet friend with embroidered seeds and green leafy top',
        'image_url': null,
        'colors': 'Red,Green',
        'sizes': 'One Size',
        'current_price': 16.00,
        'released_date': '2019-03-01T00:00:00.000',
        'retired_date': null,
        'is_new': 0,
        'is_retired': 0,
        'is_planned': 0,
        'estimated_quantity': 6000,
      },
      {
        'id': 'CORD1LION',
        'name': 'Cordy Roy Lion',
        'collection_name': 'Cordy Roy',
        'description': 'The king of the savannah in soft chunky corduroy',
        'image_url': null,
        'colors': 'Golden,Brown',
        'sizes': 'Small,Medium,Large',
        'current_price': 20.00,
        'released_date': '2012-01-01T00:00:00.000',
        'retired_date': null,
        'is_new': 0,
        'is_retired': 0,
        'is_planned': 0,
        'estimated_quantity': 4000,
      },
      {
        'id': 'BASS6DINO',
        'name': 'Bashful Dino',
        'collection_name': 'Bashful',
        'description': 'A prehistoric pal with soft green fur and spines',
        'image_url': null,
        'colors': 'Green',
        'sizes': 'Medium,Large',
        'current_price': 14.00,
        'released_date': '2020-05-01T00:00:00.000',
        'retired_date': null,
        'is_new': 1,
        'is_retired': 0,
        'is_planned': 0,
        'estimated_quantity': 7000,
      },
      {
        'id': 'FUZ2BEAR',
        'name': 'Fuddlewuddle Bear',
        'collection_name': 'Fuddlewuddle',
        'description': 'A huggable teddy with tufty, tussled fur',
        'image_url': null,
        'colors': 'Caramel,Cream',
        'sizes': 'Small,Medium',
        'current_price': 13.00,
        'released_date': '2016-11-01T00:00:00.000',
        'retired_date': null,
        'is_new': 0,
        'is_retired': 0,
        'is_planned': 0,
        'estimated_quantity': 3500,
      },
      {
        'id': 'BASS6LAMB',
        'name': 'Bashful Lamb',
        'collection_name': 'Bashful',
        'description': 'A cuddly lamb with cream and grey woolly fur',
        'image_url': null,
        'colors': 'Cream,Grey',
        'sizes': 'Small,Medium,Large',
        'current_price': 12.50,
        'released_date': '2011-03-01T00:00:00.000',
        'retired_date': null,
        'is_new': 0,
        'is_retired': 0,
        'is_planned': 0,
        'estimated_quantity': 9000,
      },
    ];

    for (final jellycat in sampleJellycats) {
      await db.insert(
        DatabaseSchema.tableJellycats,
        jellycat,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  /// Close the database
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  /// Clear all data from a table
  Future<void> clearTable(String tableName) async {
    final db = await database;
    await db.delete(tableName);
  }

  /// Clear all data from database
  Future<void> clearAllData() async {
    final db = await database;
    await db.delete(DatabaseSchema.tableJellycats);
    await db.delete(DatabaseSchema.tableUserCollection);
    await db.delete(DatabaseSchema.tableWishlist);
    await db.delete(DatabaseSchema.tableCollections);
  }
}
