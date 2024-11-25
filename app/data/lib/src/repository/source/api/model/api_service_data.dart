import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../data.dart';
import 'api_service_file.dart';
// import 'package:uuid/uuid.dart';
part 'api_service_data.freezed.dart';
part 'api_service_data.g.dart';

// @freezed
// class ApiServiceData with _$ApiServiceData {
//   const ApiServiceData._();

//   const factory ApiServiceData({
//     @JsonKey(name: 'service_uuid') String? id,
//     @JsonKey(name: 'service_name') String? name,
//     @JsonKey(name: 'shop_uuid') String? shop_id,
//     @JsonKey(name: 'category_uuid') String? category_id,
//     @JsonKey(name: 'description') String? description,
//     @JsonKey(name: 'price') double? price,
//     @JsonKey(name: 'duration') int? duration,
//     @JsonKey(name:'img') String? photos,
//   }) = _ApiServiceData;

//   factory ApiServiceData.fromJson(Map<String, dynamic> json) => _$ApiServiceDataFromJson(json);
// }

@freezed
class ApiServiceData with _$ApiServiceData {
  const ApiServiceData._();

  const factory ApiServiceData({
    @JsonKey(name: 'service') ApiServiceItemData? service,
    @JsonKey(name: 'imgs') List<ApiServiceFile>? photos,
  }) = _ApiServiceData;
  factory ApiServiceData.fromJson(Map<String, dynamic> json) => _$ApiServiceDataFromJson(json);

}