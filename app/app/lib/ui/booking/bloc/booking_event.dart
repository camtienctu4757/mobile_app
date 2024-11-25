import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../base/bloc/base_bloc_event.dart';

part 'booking_event.freezed.dart';

abstract class BookingEvent extends BaseBlocEvent {
  const BookingEvent();
}

@freezed
class SelectDay with _$SelectDay implements BookingEvent {
  const factory SelectDay({required int dayIndex}) = _SelectDay;
}

@freezed
class SelectTime with _$SelectTime implements BookingEvent {
  const factory SelectTime({required int timeIndex}) = _SelectTime;
}

@freezed
class LoadTimeList with _$LoadTimeList implements BookingEvent {
  const factory LoadTimeList({required String serviceId}) = _LoadTimeList;
}

@freezed
class InitialBookingPage with _$InitialBookingPage implements BookingEvent {
  const factory InitialBookingPage() = _InitialBookingPage;
}

@freezed
class DateSelected with _$DateSelected implements BookingEvent {
  const factory DateSelected({required String date}) = _DateSelected;
}

@freezed
class TimeSlotSelected with _$TimeSlotSelected implements BookingEvent {
  const factory TimeSlotSelected({required Map<String, Object> timeslot}) =
      _TimeSlotSelected;
}

@freezed
class AppointButtonPress with _$AppointButtonPress implements BookingEvent {
  const factory AppointButtonPress(
      {required String timeslotId}) = _AppointButtonPress;
}

@freezed
class CreateAppointMessage with _$CreateAppointMessage implements BookingEvent {
  const factory CreateAppointMessage(
      {required String message}) = _CreateAppointMessage;
}
