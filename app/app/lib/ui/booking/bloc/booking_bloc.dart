import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../app.dart';
import 'booking.dart';
import 'package:resources/resources.dart';

@Injectable()
class BookingBloc extends BaseBloc<BookingEvent, BookingState> {
  BookingBloc(this._getTimeSlotUseCase, this._createAppointUseCase)
      : super(const BookingState()) {
    print("BookingBloc created with hashCode: ${this.hashCode}");
    on<SelectDay>((event, emit) {
      emit(state.copyWith(selectedDayIndex: event.dayIndex));
    });
    on<SelectTime>((event, emit) {
      emit(state.copyWith(selectedTimeIndex: event.timeIndex));
    });
    on<LoadTimeList>(_onLoadTimeList);
    on<InitialBookingPage>(_onInitialBookingPage);
    on<DateSelected>(_onDateSelected);
    on<TimeSlotSelected>(_onLoadTimeListSelected);
    on<AppointButtonPress>(_onAppointButtonPress);
  }

  final GetTimeSlotUseCase _getTimeSlotUseCase;
  final CreateAppointUseCase _createAppointUseCase;

  Future<void> _onLoadTimeList(
      LoadTimeList event, Emitter<BookingState> emit) async {
    try {
      final response = await _getTimeSlotUseCase
          .execute(GetTimeSlotInput(serviceId: event.serviceId));
      if (response.timeslots.isNotEmpty) {
        List<Map<String, Object>> times = response.timeslots.map((timeslot) {
          return {
            'start_time': timeslot.start_time,
            'slot_date': timeslot.slot_date,
            'available': timeslot.available,
            'id': timeslot.id,
          };
        }).toList();
        emit(state.copyWith(times: times));
      }
    } catch (error) {
      logE(error.toString());
    }
  }

  FutureOr<void> _onDateSelected(
      DateSelected event, Emitter<BookingState> emit) {
    emit(state.copyWith(selectedDate: event.date));
  }

  FutureOr<void> _onInitialBookingPage(
      InitialBookingPage event, Emitter<BookingState> emit) {
    DateTime today = DateTime.now();
    List<DateTime> days = [
      today,
      today.add(const Duration(days: 1)),
      today.add(const Duration(days: 2))
    ];
    emit(state.copyWith(days: days));
  }

  FutureOr<void> _onLoadTimeListSelected(
      TimeSlotSelected event, Emitter<BookingState> emit) {
    emit(state.copyWith(timeslot: event.timeslot));
  }

  Future<void> _onAppointButtonPress(
      AppointButtonPress event, Emitter<BookingState> emit) async {
    try {
      final response = await _createAppointUseCase
          .execute(CreateAppointInput(timeslotId: event.timeslotId));
      emit(state.copyWith(createbookingMeassage: S.current.bookingsucessfully));
    } catch (error) {
      emit(state.copyWith(createbookingMeassage: S.current.bookingfail));
      logE(error.toString());
    }
  }
}
