import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_jellycat_entity.freezed.dart';

/// Domain entity representing a Jellycat in a user's collection
@freezed
class UserJellycatEntity with _$UserJellycatEntity {
  const factory UserJellycatEntity({
    required String jellycatId,
    required DateTime dateAcquired,
    @Default('Mint') String condition,
  }) = _UserJellycatEntity;
}
