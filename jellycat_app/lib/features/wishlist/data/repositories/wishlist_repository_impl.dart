import '../../domain/repositories/wishlist_repository.dart';
import '../datasources/wishlist_local_data_source.dart';

/// Implementation of wishlist repository
class WishlistRepositoryImpl implements WishlistRepository {
  final WishlistLocalDataSource localDataSource;

  WishlistRepositoryImpl({required this.localDataSource});

  @override
  Future<List<String>> getWishlistJellycatIds() async {
    return await localDataSource.getAllJellycatIds();
  }

  @override
  Future<bool> isInWishlist(String jellycatId) async {
    return await localDataSource.isInWishlist(jellycatId);
  }

  @override
  Future<void> addToWishlist(String jellycatId) async {
    await localDataSource.add(jellycatId);
  }

  @override
  Future<void> removeFromWishlist(String jellycatId) async {
    await localDataSource.remove(jellycatId);
  }
}
