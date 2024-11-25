import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/app.dart';
part 'appointment_event.freezed.dart';

abstract class AppointmentEvent extends BaseBlocEvent {
  const AppointmentEvent();
}

@freezed
class LoadAppointments extends AppointmentEvent with _$LoadAppointments {
  const factory LoadAppointments() = _LoadAppointments;
}

@freezed
class ConfirmedAppointments extends AppointmentEvent
    with _$ConfirmedAppointments {
  const factory ConfirmedAppointments() = _ConfirmedAppointments;
}

@freezed
class AppointmentsTab extends AppointmentEvent
    with _$AppointmentsTab {
  const factory AppointmentsTab({
    required int tabIndex
  }) = _AppointmentsTab;
}

@freezed
class CanceledAppointmentsPress extends AppointmentEvent
    with _$CanceledAppointmentsPress {
  const factory CanceledAppointmentsPress() = _CanceledAppointmentsPress;
}

@freezed
class PendingCancelAppointments extends AppointmentEvent
    with _$PendingCancelAppointments {
  const factory PendingCancelAppointments() = _PendingCancelAppointments;
}

@freezed
class LoadAppointmentsSuccess extends AppointmentEvent with _$LoadAppointmentsSuccess {
  const factory LoadAppointmentsSuccess() = _LoadAppointmentsSuccess;
}

@freezed
class LoadAppointmentsCancle extends AppointmentEvent with _$LoadAppointmentsCancle {
  const factory LoadAppointmentsCancle() = _LoadAppointmentsCancle;
}

@freezed
class LoadAppointmentsPending extends AppointmentEvent with _$LoadAppointmentsPending {
  const factory LoadAppointmentsPending() = _LoadAppointmentsPending;
}

@freezed
class PressCancleAppointment extends AppointmentEvent with _$PressCancleAppointment {
  const factory PressCancleAppointment({
    required String appoint_id
  }) = _PressCancleAppointment;
}