import 'package:freezed_annotation/freezed_annotation.dart';
part 'appointment_item.freezed.dart';

@freezed
class AppointmentItem with _$AppointmentItem {
  const factory AppointmentItem(
      {
      @Default(AppointmentItem.defaultId) String id,  
      @Default(AppointmentItem.defaultServicename) String serviceName,
      @Default(AppointmentItem.defaultPrice) double price,
      @Default(AppointmentItem.defaultDuration) int duration,
      @Default(AppointmentItem.defaultStoreName) String storeName,
      @Default(AppointmentItem.defaultStoreAddress) String storeAddress,
      @Default(AppointmentItem.defaultAppointmentTime) String appointmentTime,
      @Default(AppointmentItem.defaultAppointmentDate) String appointmentDate
      }) = _AppointmentItem;
  static const defaultId = '';
  static const defaultServicename = '';
  static const defaultPrice = 0.0;
  static const defaultDuration = 0;
  static const defaultStoreName = '';
  static const defaultStoreAddress = '';
  static const defaultAppointmentTime = '';
  static const defaultAppointmentDate = '';

}
