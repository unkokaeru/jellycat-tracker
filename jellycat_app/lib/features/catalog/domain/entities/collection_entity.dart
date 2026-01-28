import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection_entity.freezed.dart';

/// Domain entity representing a Jellycat collection (e.g., Bashful, Amuseables)
@freezed
class CollectionEntity with _$CollectionEntity {
  const factory CollectionEntity({
    required String name,
    String? description,
    String? imageUrl,
    required List<String> jellycatIds,
    required int totalCount,
  }) = _CollectionEntity;
}
