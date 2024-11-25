import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../base/bloc/base_bloc_state.dart';

part 'booking_state.freezed.dart';

@freezed
class BookingState extends BaseBlocState with _$BookingState {
  const BookingState._(); 
  const factory BookingState({
    @Default(false) bool logoutSuccess, 
    @Default(0) int selectedDayIndex,
    @Default(0) int selectedTimeIndex,
    @Default([]) List<DateTime> days, 
    @Default('')String selectedDate,
    @Default('')String selectedtime,
    @Default([{}]) List<Map<String, Object>> times,
    @Default({}) Map<String, Object> timeslot,
    @Default(false) bool appointSuccess,
    @Default('') String createbookingMeassage
  }) = _BookingState;
}
