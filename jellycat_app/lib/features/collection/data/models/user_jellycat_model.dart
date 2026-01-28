import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_jellycat_model.freezed.dart';

/// Data model for user's Jellycat in collection
@freezed
class UserJellycatModel with _$UserJellycatModel {
  const factory UserJellycatModel({
    required String jellycatId,
    required DateTime dateAcquired,
    @Default('Mint') String condition,
  }) = _UserJellycatModel;
}
