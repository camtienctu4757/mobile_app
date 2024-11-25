import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'api_get_booking.freezed.dart';
part 'api_get_booking.g.dart';

@freezed
class ApiGetBooking with _$ApiGetBooking {
  const ApiGetBooking._();

  const factory ApiGetBooking({
    @JsonKey(name: 'appointment_uuid') String? id,
    @JsonKey(name: 'service_name') String? service_name,
    @JsonKey(name: 'price') double? price,
    @JsonKey(name: 'duration') int? duration,
    @JsonKey(name: 'shop_name') String? shop_name,
    @JsonKey(name: 'slot_date') String? slot_date, 
    @JsonKey(name: 'start_time') String? start_time, 
    @JsonKey(name: 'address') String? address 
  }) = _ApiGetBooking;
  factory ApiGetBooking.fromJson(Map<String, dynamic> json) => _$ApiGetBookingFromJson(json);

}