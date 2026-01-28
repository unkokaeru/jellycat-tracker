import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/providers/app_providers.dart';
import '../../catalog/domain/entities/jellycat_entity.dart';
import '../../catalog/presentation/providers/catalog_providers.dart';

/// Provider to get wishlist Jellycat IDs
final wishlistIdsProvider = FutureProvider<List<String>>((ref) async {
  final repository = ref.watch(wishlistRepositoryProvider);
  return await repository.getWishlistJellycatIds();
});

/// Provider to get wishlist Jellycats (full entities)
final wishlistJellycatsProvider =
    FutureProvider<List<JellycatEntity>>((ref) async {
  final wishlistIds = await ref.watch(wishlistIdsProvider.future);
  final allJellycats = await ref.watch(allJellycatsProvider.future);

  return allJellycats
      .where((jellycat) => wishlistIds.contains(jellycat.id))
      .toList();
});

/// Provider to check if a Jellycat is in wishlist
final isInWishlistProvider =
    FutureProvider.family<bool, String>((ref, jellycatId) async {
  final repository = ref.watch(wishlistRepositoryProvider);
  return await repository.isInWishlist(jellycatId);
});

/// Provider to calculate total wishlist value
final wishlistValueProvider = FutureProvider<double>((ref) async {
  final wishlistJellycats = await ref.watch(wishlistJellycatsProvider.future);
  
  double totalValue = 0.0;
  for (final jellycat in wishlistJellycats) {
    totalValue += jellycat.currentPrice ?? 0.0;
  }
  
  return totalValue;
});

/// Provider to add/remove from wishlist
class WishlistNotifier extends StateNotifier<AsyncValue<void>> {
  WishlistNotifier(this.ref) : super(const AsyncValue.data(null));

  final Ref ref;

  Future<void> addToWishlist(String jellycatId) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(wishlistRepositoryProvider);
      await repository.addToWishlist(jellycatId);
      
      // Invalidate providers to refresh data
      ref.invalidate(wishlistIdsProvider);
      ref.invalidate(isInWishlistProvider(jellycatId));
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> removeFromWishlist(String jellycatId) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(wishlistRepositoryProvider);
      await repository.removeFromWishlist(jellycatId);
      
      // Invalidate providers to refresh data
      ref.invalidate(wishlistIdsProvider);
      ref.invalidate(isInWishlistProvider(jellycatId));
      
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

final wishlistNotifierProvider =
    StateNotifierProvider<WishlistNotifier, AsyncValue<void>>((ref) {
  return WishlistNotifier(ref);
});
