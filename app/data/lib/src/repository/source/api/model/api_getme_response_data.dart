import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_getme_response_data.freezed.dart';
part 'api_getme_response_data.g.dart';

@freezed
class ApiGetmeResponseData with _$ApiGetmeResponseData {
  const factory ApiGetmeResponseData({
    @JsonKey(name: 'user_uuid') String? user_uuid,
    @JsonKey(name: 'username') String? name,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'phone_number') String? phone_number,
  }) = _ApiGetmeResponseData;

  factory ApiGetmeResponseData.fromJson(Map<String, dynamic> json) =>
      _$ApiGetmeResponseDataFromJson(json);
}