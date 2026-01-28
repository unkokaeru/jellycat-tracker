import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/database/sqlite_service.dart';
import '../features/catalog/data/datasources/jellycat_local_data_source.dart';
import '../features/catalog/data/repositories/jellycat_repository_impl.dart';
import '../features/catalog/domain/repositories/jellycat_repository.dart';
import '../features/collection/data/datasources/user_collection_local_data_source.dart';
import '../features/collection/data/repositories/user_collection_repository_impl.dart';
import '../features/collection/domain/repositories/user_collection_repository.dart';
import '../features/wishlist/data/datasources/wishlist_local_data_source.dart';
import '../features/wishlist/data/repositories/wishlist_repository_impl.dart';
import '../features/wishlist/domain/repositories/wishlist_repository.dart';

/// Database service provider
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

/// Jellycat local data source provider
final jellycatLocalDataSourceProvider =
    Provider<JellycatLocalDataSource>((ref) {
  return JellycatLocalDataSourceImpl(
    databaseService: ref.watch(databaseServiceProvider),
  );
});

/// Jellycat repository provider
final jellycatRepositoryProvider = Provider<JellycatRepository>((ref) {
  return JellycatRepositoryImpl(
    localDataSource: ref.watch(jellycatLocalDataSourceProvider),
  );
});

/// User collection local data source provider
final userCollectionLocalDataSourceProvider =
    Provider<UserCollectionLocalDataSource>((ref) {
  return UserCollectionLocalDataSourceImpl(
    databaseService: ref.watch(databaseServiceProvider),
  );
});

/// User collection repository provider
final userCollectionRepositoryProvider =
    Provider<UserCollectionRepository>((ref) {
  return UserCollectionRepositoryImpl(
    localDataSource: ref.watch(userCollectionLocalDataSourceProvider),
  );
});

/// Wishlist local data source provider
final wishlistLocalDataSourceProvider =
    Provider<WishlistLocalDataSource>((ref) {
  return WishlistLocalDataSourceImpl(
    databaseService: ref.watch(databaseServiceProvider),
  );
});

/// Wishlist repository provider
final wishlistRepositoryProvider = Provider<WishlistRepository>((ref) {
  return WishlistRepositoryImpl(
    localDataSource: ref.watch(wishlistLocalDataSourceProvider),
  );
});
