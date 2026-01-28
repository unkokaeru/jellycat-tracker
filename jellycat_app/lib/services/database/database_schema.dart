/// Database schema constants for SQLite database
class DatabaseSchema {
  DatabaseSchema._();

  static const String databaseName = 'jellycat_tracker.db';
  static const int databaseVersion = 1;

  // Table names
  static const String tableJellycats = 'jellycats';
  static const String tableUserCollection = 'user_collection';
  static const String tableWishlist = 'wishlist';
  static const String tableCollections = 'collections';

  // Jellycats table schema
  static const String createJellycatsTable = '''
    CREATE TABLE $tableJellycats (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      collection_name TEXT NOT NULL,
      description TEXT,
      image_url TEXT,
      colors TEXT NOT NULL,
      sizes TEXT NOT NULL,
      current_price REAL,
      released_date TEXT NOT NULL,
      retired_date TEXT,
      is_new INTEGER NOT NULL DEFAULT 0,
      is_retired INTEGER NOT NULL DEFAULT 0,
      is_planned INTEGER NOT NULL DEFAULT 0,
      estimated_quantity INTEGER DEFAULT 0,
      synced_at TEXT DEFAULT CURRENT_TIMESTAMP
    )
  ''';

  // User collection table schema
  static const String createUserCollectionTable = '''
    CREATE TABLE $tableUserCollection (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      jellycat_id TEXT NOT NULL UNIQUE,
      date_acquired TEXT DEFAULT CURRENT_TIMESTAMP,
      condition TEXT DEFAULT 'Mint',
      FOREIGN KEY(jellycat_id) REFERENCES $tableJellycats(id) ON DELETE CASCADE
    )
  ''';

  // Wishlist table schema
  static const String createWishlistTable = '''
    CREATE TABLE $tableWishlist (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      jellycat_id TEXT NOT NULL UNIQUE,
      date_added TEXT DEFAULT CURRENT_TIMESTAMP,
      priority INTEGER DEFAULT 5,
      notes TEXT,
      FOREIGN KEY(jellycat_id) REFERENCES $tableJellycats(id) ON DELETE CASCADE
    )
  ''';

  // Collections table schema
  static const String createCollectionsTable = '''
    CREATE TABLE $tableCollections (
      name TEXT PRIMARY KEY,
      description TEXT,
      image_url TEXT,
      created_date TEXT DEFAULT CURRENT_TIMESTAMP
    )
  ''';

  // Indexes for performance
  static const String createJellycatsCollectionIndex = '''
    CREATE INDEX idx_jellycats_collection ON $tableJellycats(collection_name)
  ''';

  static const String createJellycatsReleasedDateIndex = '''
    CREATE INDEX idx_jellycats_released_date ON $tableJellycats(released_date)
  ''';

  static const String createUserCollectionDateIndex = '''
    CREATE INDEX idx_user_collection_date ON $tableUserCollection(date_acquired)
  ''';

  /// Get all create table statements
  static List<String> get createTableStatements => [
        createJellycatsTable,
        createUserCollectionTable,
        createWishlistTable,
        createCollectionsTable,
      ];

  /// Get all index creation statements
  static List<String> get createIndexStatements => [
        createJellycatsCollectionIndex,
        createJellycatsReleasedDateIndex,
        createUserCollectionDateIndex,
      ];
}
