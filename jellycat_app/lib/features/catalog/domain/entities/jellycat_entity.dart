import 'package:freezed_annotation/freezed_annotation.dart';

part 'jellycat_entity.freezed.dart';

/// Domain entity representing a Jellycat plushie
@freezed
class JellycatEntity with _$JellycatEntity {
  const factory JellycatEntity({
    required String id,
    required String name,
    required String collectionName,
    String? description,
    String? imageUrl,
    required List<String> colors,
    required List<String> sizes,
    double? currentPrice,
    required DateTime releasedDate,
    DateTime? retiredDate,
    required bool isNew,
    required bool isRetired,
    required bool isPlanned,
    @Default(0) int estimatedQuantity,
  }) = _JellycatEntity;

  const JellycatEntity._();

  /// Get formatted price string
  String get formattedPrice {
    if (currentPrice == null) return 'Price not available';
    return '£${currentPrice!.toStringAsFixed(2)}';
  }

  /// Get status label
  String get statusLabel {
    if (isRetired) return 'Retired';
    if (isNew) return 'New';
    if (isPlanned) return 'Planned';
    return 'Available';
  }

  /// Get status color based on state
  String get statusColor {
    if (isRetired) return 'error';
    if (isNew) return 'info';
    if (isPlanned) return 'warning';
    return 'success';
  }
}
