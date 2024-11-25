import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../base/bloc/base_bloc_state.dart';
part 'appointment_state.freezed.dart';

@freezed
class AppointmentState extends BaseBlocState with _$AppointmentState {
  factory AppointmentState({
    @Default(<AppointmentItem>[]) List<AppointmentItem?> appointments_list,
    @Default(<AppointmentItem>[]) List<AppointmentItem?> appointments_success,
    @Default(<AppointmentItem>[]) List<AppointmentItem?> appointments_pending,
    @Default(<AppointmentItem>[]) List<AppointmentItem?> appointments_cancle,
    @Default(false) bool isLoading,
    AppException? loadUsersException,
    @Default(1) int tabIndex,
    @Default(false) bool isUpdateSuccess
  }) = _AppointmentState;
}