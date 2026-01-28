/// Repository interface for user collection
abstract class UserCollectionRepository {
  Future<List<String>> getCollectionJellycatIds();
  Future<bool> isInCollection(String jellycatId);
  Future<void> addToCollection(String jellycatId);
  Future<void> removeFromCollection(String jellycatId);
}
