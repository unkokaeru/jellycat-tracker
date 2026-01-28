/// Repository interface for wishlist
abstract class WishlistRepository {
  Future<List<String>> getWishlistJellycatIds();
  Future<bool> isInWishlist(String jellycatId);
  Future<void> addToWishlist(String jellycatId);
  Future<void> removeFromWishlist(String jellycatId);
}
