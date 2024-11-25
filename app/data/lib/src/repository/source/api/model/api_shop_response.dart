import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_shop_response.freezed.dart';
part 'api_shop_response.g.dart';

@freezed
class ApiGetShopResponseData with _$ApiGetShopResponseData {
  const factory ApiGetShopResponseData({
    @JsonKey(name: 'shop_uuid') String? shopId,
    @JsonKey(name: 'shop_name') String? name,
    @JsonKey(name: 'open_time') String? openTime,
    @JsonKey(name: 'closed_time') String? closedTime,
    @JsonKey(name: 'address') String? address,
    @JsonKey(name: 'email')  String? email,
    @JsonKey(name: 'phone')  String? phone,
  }) = _ApiGetShopResponseData;

  factory ApiGetShopResponseData.fromJson(Map<String, dynamic> json) => _$ApiGetShopResponseDataFromJson(json);
}
