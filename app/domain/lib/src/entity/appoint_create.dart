import 'package:freezed_annotation/freezed_annotation.dart';
part 'appoint_create.freezed.dart';



@freezed
class AppointmentCreate with _$AppointmentCreate {
  const factory AppointmentCreate(
      {
      @Default(AppointmentCreate.defaultId) String id,  
      @Default(AppointmentCreate.defaultUserId) String user_uuid,
      @Default(AppointmentCreate.defaultStatus) String status,
      @Default(AppointmentCreate.defaultTimeSlotId) String timeslot_uuid,
      }) = _AppointmentCreate;
  static const defaultId = '';
  static const defaultUserId = '';
  static const defaultTimeSlotId = '';
  static const defaultStatus = '';
}
