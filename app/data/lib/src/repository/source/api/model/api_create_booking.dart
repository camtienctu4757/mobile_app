import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_create_booking.freezed.dart';
part 'api_create_booking.g.dart';

@freezed
class ApiCreateBooking with _$ApiCreateBooking {
  const ApiCreateBooking._();
  const factory ApiCreateBooking({
    @JsonKey(name: 'appointment_uuid') String? id,
    @JsonKey(name: 'timeslot_uuid') String? timeslot_id,
    @JsonKey(name: 'status') String? status,
    @JsonKey(name: 'user_uuid') String? user_id,
  }) = _ApiCreateBooking;
  factory ApiCreateBooking.fromJson(Map<String, dynamic> json) => _$ApiCreateBookingFromJson(json);

}