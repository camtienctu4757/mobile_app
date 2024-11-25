import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'service_item.freezed.dart';
part 'service_item.g.dart';
@freezed
class ApiServiceItemData with _$ApiServiceItemData {
  const ApiServiceItemData._();

  const factory ApiServiceItemData({
    @JsonKey(name: 'service_uuid') String? id,
    @JsonKey(name: 'service_name') String? name,
    @JsonKey(name: 'shop_uuid') String? shop_id,
    @JsonKey(name: 'category_uuid') String? category_id,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'price') double? price,
    @JsonKey(name: 'duration') int? duration,
    @JsonKey(name: 'img') String? photos,
    @JsonKey(name: 'created_at') String? createdAt, 
    @JsonKey(name: 'updated_at') String? updatedAt,  
    @JsonKey(name: 'employee') int? employee,  
  }) = _ApiServiceItemData;
  factory ApiServiceItemData.fromJson(Map<String, dynamic> json) => _$ApiServiceItemDataFromJson(json);

}