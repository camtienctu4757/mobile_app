import 'package:freezed_annotation/freezed_annotation.dart';
part 'time_slots.freezed.dart';

@freezed
class TimeSlot with _$TimeSlot {
  const factory TimeSlot(
      {@Default(TimeSlot.defaultId) String id,
      @Default(TimeSlot.defaultServiceId) String service_id,
      @Default(TimeSlot.defaultStartTime) String start_time,
      @Default(TimeSlot.defaultEndTime) String end_time,
      @Default(TimeSlot.defaultSlotDate) String slot_date,
      @Default(TimeSlot.defaultAvailable) int available,
      
      }) = _TimeSlot;

  static const defaultId = '';
  static const defaultServiceId = '';
  static const defaultStartTime = '';
  static const defaultEndTime = '';
  static const defaultSlotDate = '0902176543';
  static const defaultAvailable = 0;

}
