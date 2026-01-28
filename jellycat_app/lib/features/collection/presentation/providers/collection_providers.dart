import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/app_providers.dart';
import '../../catalog/domain/entities/jellycat_entity.dart';
import '../../catalog/presentation/providers/catalog_providers.dart';

/// Provider to get user's collection Jellycat IDs
final userCollectionIdsProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(userCollectionRepositoryProvider);
  return await repository.getCollectionJellycatIds();
});

/// Provider to get user's collection Jellycats (full entities)
final userCollectionJellycatsProvider =
    FutureProvider<List<JellycatEntity>>((ref) async {
  final collectionIds = await ref.watch(userCollectionIdsProvider.future);
  final allJellycats = await ref.watch(allJellycatsProvider.future);

  return allJellycats
      .where((jellycat) => collectionIds.contains(jellycat.id))
      .toList();
});

/// Provider to check if a Jellycat is in collection
final isInCollectionProvider =
    FutureProvider.family<bool, String>((ref, jellycatId) async {
  final repository = ref.watch(userCollectionRepositoryProvider);
  return await repository.isInCollection(jellycatId);
});

/// Provider to calculate total collection value
final collectionValueProvider = FutureProvider<double>((ref) async {
  final collectionJellycats = await ref.watch(userCollectionJellycatsProvider.future);
  
  double totalValue = 0.0;
  for (final jellycat in collectionJellycats) {
    totalValue += jellycat.currentPrice ?? 0.0;
  }
  
  return totalValue;
});

/// Provider to add/remove from collection
class CollectionNotifier extends StateNotifier<AsyncValue<void>> {
  CollectionNotifier(this.ref) : super(const AsyncValue.data(null));

  final Ref ref;

  Future<void> addToCollection(String jellycatId) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(userCollectionRepositoryProvider);
      await repository.addToCollection(jellycatId);
      
      // Invalidate providers to refresh data
      ref.invalidate(userCollectionIdsProvider);
      ref.invalidate(isInCollectionProvider(jellycatId));
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> removeFromCollection(String jellycatId) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(userCollectionRepositoryProvider);
      await repository.removeFromCollection(jellycatId);
      
      // Invalidate providers to refresh data
      ref.invalidate(userCollectionIdsProvider);
      ref.invalidate(isInCollectionProvider(jellycatId));
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final collectionNotifierProvider =
    StateNotifierProvider<CollectionNotifier, AsyncValue<void>>((ref) {
  return CollectionNotifier(ref);
});
