import '../entities/jellycat_entity.dart';

/// Repository interface for Jellycat catalog
abstract class JellycatRepository {
  Future<List<JellycatEntity>> getAllJellycats();
  Future<JellycatEntity?> getJellycatById(String id);
  Future<List<JellycatEntity>> getJellycatsByCollection(String collectionName);
  Future<List<String>> getAllCollections();
}
