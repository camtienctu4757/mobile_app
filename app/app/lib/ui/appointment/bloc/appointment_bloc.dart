import 'dart:async';

import 'package:domain/domain.dart';

import 'package:app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'appointment.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AppointmentBloc extends BaseBloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc(
      this._getAppointSuccessUseCase,
      this._getBookingCancleUseCase,
      this._getBookingPendingUseCase,
      this._userUpdateBookingCancleUseCase)
      : super(AppointmentState()) {
    on<PressCancleAppointment>(_onPressCancleAppointment);
    on<LoadAppointmentsPending>(_onAppointmentsTablePending); //
    on<LoadAppointmentsSuccess>(_onAppointmentsTableSuccess); //
    on<LoadAppointmentsCancle>(_onAppointmentsTableCancle); //
    on<AppointmentsTab>(
      _onAppointmentsTab,
    );
  }
  final GetBookingCancleUseCase _getBookingCancleUseCase;
  final GetBookingPendingUseCase _getBookingPendingUseCase;
  final GetAppointSuccessUseCase _getAppointSuccessUseCase;
  final UserUpdateBookingCancleUseCase _userUpdateBookingCancleUseCase;

  FutureOr<void> _onPressCancleAppointment(
      PressCancleAppointment event, Emitter<AppointmentState> emit) async {
    try {
      final result = await _userUpdateBookingCancleUseCase
          .execute(UserUpdateBookingCancleInput(id: event.appoint_id));
      emit(state.copyWith(isUpdateSuccess: result.isSuccess));
    } catch (error) {
      logD("Error loading image: $error");
    }
  }

  FutureOr<void> _onAppointmentsTablePending(
      LoadAppointmentsPending event, Emitter<AppointmentState> emit) async {
    try {
      final result = await _getBookingPendingUseCase
          .execute(const GetBookingPendingInput());
      // print(result.booking_pending.toString());
      emit(state.copyWith(appointments_list: result.booking_pending));
    } catch (error) {}
  }

  FutureOr<void> _onAppointmentsTableSuccess(
      LoadAppointmentsSuccess event, Emitter<AppointmentState> emit) async {
    try {
      final result = await _getAppointSuccessUseCase
          .execute(const GetAppointSuccessInput());
      emit(state.copyWith(appointments_list: result.booking_success));
    } catch (error) {}
  }

  FutureOr<void> _onAppointmentsTableCancle(
      LoadAppointmentsCancle event, Emitter<AppointmentState> emit) async {
    try {
      final result =
          await _getBookingCancleUseCase.execute(const GetBookingCancleInput());
      emit(state.copyWith(appointments_list: result.booking_cancle));
    } catch (error) {}
  }

  FutureOr<void> _onAppointmentsTab(
      AppointmentsTab event, Emitter<AppointmentState> emit) async {
    emit(state.copyWith(tabIndex: event.tabIndex));
  }
}
