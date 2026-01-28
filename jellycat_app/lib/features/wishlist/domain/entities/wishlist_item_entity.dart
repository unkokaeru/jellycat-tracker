import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_item_entity.freezed.dart';

/// Domain entity representing a wishlist item
@freezed
class WishlistItemEntity with _$WishlistItemEntity {
  const factory WishlistItemEntity({
    required String jellycatId,
    required DateTime dateAdded,
    @Default(5) int priority, // 1=Urgent, 5=Nice to have
    String? notes,
  }) = _WishlistItemEntity;
}
