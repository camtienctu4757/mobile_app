import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_get_time_slot.freezed.dart';
part 'api_get_time_slot.g.dart';
@freezed
class ApiGetTimeSlot with _$ApiGetTimeSlot {
  const ApiGetTimeSlot._();

  const factory ApiGetTimeSlot({
    @JsonKey(name: 'slot_uuid') String? id,
    @JsonKey(name: 'service_uuid') String? servie_id,
    @JsonKey(name: 'end_time') String? end_time,
    @JsonKey(name: 'slot_date') String? slot_date,
    @JsonKey(name: 'available_employees') int? available,
    @JsonKey(name: 'start_time') String? start_time,
    @JsonKey(name: 'created_at') String? createdAt, 
    @JsonKey(name: 'updated_at') String? updatedAt,  
  }) = _ApiGetTimeSlot;
  factory ApiGetTimeSlot.fromJson(Map<String, dynamic> json) => _$ApiGetTimeSlotFromJson(json);

}