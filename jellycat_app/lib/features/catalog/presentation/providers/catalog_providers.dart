import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/app_providers.dart';
import '../../catalog/domain/entities/jellycat_entity.dart';

/// Provider to get all Jellycats
final allJellycatsProvider = FutureProvider<List<JellycatEntity>>((ref) async {
  final repository = ref.watch(jellycatRepositoryProvider);
  return await repository.getAllJellycats();
});

/// Provider to get all collections
final allCollectionsProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(jellycatRepositoryProvider);
  return await repository.getAllCollections();
});

/// Provider to get Jellycats filtered by collection
final jellycatsByCollectionProvider =
    FutureProvider.family<List<JellycatEntity>, String?>((ref, collectionName) async {
  final repository = ref.watch(jellycatRepositoryProvider);
  
  if (collectionName == null || collectionName.isEmpty) {
    return await repository.getAllJellycats();
  }
  
  return await repository.getJellycatsByCollection(collectionName);
});

/// Provider to get a specific Jellycat by ID
final jellycatByIdProvider =
    FutureProvider.family<JellycatEntity?, String>((ref, id) async {
  final repository = ref.watch(jellycatRepositoryProvider);
  return await repository.getJellycatById(id);
});

/// Selected collection filter state provider
final selectedCollectionProvider = StateProvider<String?>((ref) => null);

/// Filtered Jellycats based on selected collection
final filteredJellycatsProvider = FutureProvider<List<JellycatEntity>>((ref) async {
  final selectedCollection = ref.watch(selectedCollectionProvider);
  final jellycats = await ref.watch(jellycatsByCollectionProvider(selectedCollection).future);
  return jellycats;
});
