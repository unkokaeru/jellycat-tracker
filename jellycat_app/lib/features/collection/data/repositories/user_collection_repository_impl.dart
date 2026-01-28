import '../../domain/repositories/user_collection_repository.dart';
import '../datasources/user_collection_local_data_source.dart';

/// Implementation of user collection repository
class UserCollectionRepositoryImpl implements UserCollectionRepository {
  final UserCollectionLocalDataSource localDataSource;

  UserCollectionRepositoryImpl({required this.localDataSource});

  @override
  Future<List<String>> getCollectionJellycatIds() async {
    return await localDataSource.getAllJellycatIds();
  }

  @override
  Future<bool> isInCollection(String jellycatId) async {
    return await localDataSource.isInCollection(jellycatId);
  }

  @override
  Future<void> addToCollection(String jellycatId) async {
    await localDataSource.add(jellycatId);
  }

  @override
  Future<void> removeFromCollection(String jellycatId) async {
    await localDataSource.remove(jellycatId);
  }
}
