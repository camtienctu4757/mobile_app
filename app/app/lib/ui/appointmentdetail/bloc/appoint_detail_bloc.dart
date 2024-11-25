import 'package:flutter_bloc/flutter_bloc.dart';
import 'appoint_detail_event.dart';
import 'appoint_detail_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentInitial()) {
    on<LoadAppointmentDetails>((event, emit) {
      // Giả sử ngày hẹn ban đầu là 17/07/2024 10:00 AM
      emit(AppointmentLoaded(DateTime(2024, 7, 17, 10, 0)));
    });

    on<CancelAppointment>((event, emit) {
      emit(AppointmentCancelled());
    });

    on<UpdateAppointmentTime>((event, emit) {
      emit(AppointmentTimeUpdated(event.selectedTime));
    });
  }
}
