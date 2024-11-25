import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_auth_response_data.freezed.dart';
part 'api_auth_response_data.g.dart';

@freezed
class ApiAuthResponseData with _$ApiAuthResponseData {
  const factory ApiAuthResponseData({
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'token_type') String? tokenType,
    @JsonKey(name: 'refresh_token') String? refreshToken,
    @JsonKey(name: 'scope') String? scope,
    @JsonKey(name: 'session_state') String? sessionState,
    @JsonKey(name: 'not-before-policy') int? notBeforePolicy,
    @JsonKey(name: 'refresh_expires_in') int? refreshExpiresIn,
    @JsonKey(name: 'expires_in') int? expiresIn,
  }) = _ApiAuthResponseData;

  factory ApiAuthResponseData.fromJson(Map<String, dynamic> json) =>
      _$ApiAuthResponseDataFromJson(json);
}
