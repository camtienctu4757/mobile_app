import 'package:equatable/equatable.dart';

abstract class AppointmentEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadAppointmentDetails extends AppointmentEvent {}
class CancelAppointment extends AppointmentEvent {}
class UpdateAppointmentTime extends AppointmentEvent {
  final DateTime selectedTime;
  UpdateAppointmentTime(this.selectedTime);

  @override
  List<Object> get props => [selectedTime];
}
