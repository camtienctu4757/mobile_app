import 'package:equatable/equatable.dart';

abstract class AppointmentState extends Equatable {
  @override
  List<Object> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final DateTime appointmentTime;
  AppointmentLoaded(this.appointmentTime);

  @override
  List<Object> get props => [appointmentTime];
}

class AppointmentCancelled extends AppointmentState {}

class AppointmentTimeUpdated extends AppointmentState {
  final DateTime newTime;
  AppointmentTimeUpdated(this.newTime);

  @override
  List<Object> get props => [newTime];
}
