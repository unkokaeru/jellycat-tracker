import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/jellycat_entity.dart';

part 'jellycat_model.freezed.dart';
part 'jellycat_model.g.dart';

/// Data model for Jellycat with JSON and SQLite serialization
@freezed
class JellycatModel with _$JellycatModel {
  const factory JellycatModel({
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
  }) = _JellycatModel;

  const JellycatModel._();

  factory JellycatModel.fromJson(Map<String, dynamic> json) =>
      _$JellycatModelFromJson(json);

  /// Convert from SQLite map
  factory JellycatModel.fromSqlite(Map<String, dynamic> map) {
    return JellycatModel(
      id: map['id'] as String,
      name: map['name'] as String,
      collectionName: map['collection_name'] as String,
      description: map['description'] as String?,
      imageUrl: map['image_url'] as String?,
      colors: (map['colors'] as String).split(','),
      sizes: (map['sizes'] as String).split(','),
      currentPrice: map['current_price'] as double?,
      releasedDate: DateTime.parse(map['released_date'] as String),
      retiredDate: map['retired_date'] != null
          ? DateTime.parse(map['retired_date'] as String)
          : null,
      isNew: (map['is_new'] as int) == 1,
      isRetired: (map['is_retired'] as int) == 1,
      isPlanned: (map['is_planned'] as int) == 1,
      estimatedQuantity: map['estimated_quantity'] as int? ?? 0,
    );
  }

  /// Convert to SQLite map
  Map<String, dynamic> toSqlite() {
    return {
      'id': id,
      'name': name,
      'collection_name': collectionName,
      'description': description,
      'image_url': imageUrl,
      'colors': colors.join(','),
      'sizes': sizes.join(','),
      'current_price': currentPrice,
      'released_date': releasedDate.toIso8601String(),
      'retired_date': retiredDate?.toIso8601String(),
      'is_new': isNew ? 1 : 0,
      'is_retired': isRetired ? 1 : 0,
      'is_planned': isPlanned ? 1 : 0,
      'estimated_quantity': estimatedQuantity,
    };
  }

  /// Convert to domain entity
  JellycatEntity toDomain() {
    return JellycatEntity(
      id: id,
      name: name,
      collectionName: collectionName,
      description: description,
      imageUrl: imageUrl,
      colors: colors,
      sizes: sizes,
      currentPrice: currentPrice,
      releasedDate: releasedDate,
      retiredDate: retiredDate,
      isNew: isNew,
      isRetired: isRetired,
      isPlanned: isPlanned,
      estimatedQuantity: estimatedQuantity,
    );
  }

  /// Create from domain entity
  factory JellycatModel.fromDomain(JellycatEntity entity) {
    return JellycatModel(
      id: entity.id,
      name: entity.name,
      collectionName: entity.collectionName,
      description: entity.description,
      imageUrl: entity.imageUrl,
      colors: entity.colors,
      sizes: entity.sizes,
      currentPrice: entity.currentPrice,
      releasedDate: entity.releasedDate,
      retiredDate: entity.retiredDate,
      isNew: entity.isNew,
      isRetired: entity.isRetired,
      isPlanned: entity.isPlanned,
      estimatedQuantity: entity.estimatedQuantity,
    );
  }
}
