import 'package:freezed_annotation/freezed_annotation.dart';
part 'api_user_data.freezed.dart';
part 'api_user_data.g.dart';

@freezed
class ApiUserData with _$ApiUserData {
  const ApiUserData._();

  const factory ApiUserData({
    // @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'user_uuid') String? id,
    @JsonKey(name:'username') String? name,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'phone_number') String? phone,

  }) = _ApiUserData;

  factory ApiUserData.fromJson(Map<String, dynamic> json) => _$ApiUserDataFromJson(json);
}
