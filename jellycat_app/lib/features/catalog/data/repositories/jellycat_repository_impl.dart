import '../../domain/entities/jellycat_entity.dart';
import '../../domain/repositories/jellycat_repository.dart';
import '../datasources/jellycat_local_data_source.dart';

/// Implementation of Jellycat repository using local data source
class JellycatRepositoryImpl implements JellycatRepository {
  final JellycatLocalDataSource localDataSource;

  JellycatRepositoryImpl({required this.localDataSource});

  @override
  Future<List<JellycatEntity>> getAllJellycats() async {
    final models = await localDataSource.getAll();
    return models.map((model) => model.toDomain()).toList();
  }

  @override
  Future<JellycatEntity?> getJellycatById(String id) async {
    final model = await localDataSource.getById(id);
    return model?.toDomain();
  }

  @override
  Future<List<JellycatEntity>> getJellycatsByCollection(
      String collectionName) async {
    final models = await localDataSource.getByCollection(collectionName);
    return models.map((model) => model.toDomain()).toList();
  }

  @override
  Future<List<String>> getAllCollections() async {
    return await localDataSource.getAllCollections();
  }
}
