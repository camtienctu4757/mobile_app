import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/app.dart';
part 'restday_event.freezed.dart';

abstract class RestDayEvent extends BaseBlocEvent {
  const RestDayEvent();
}

@freezed
class AddRestDayEvent extends RestDayEvent with _$AddRestDayEvent {
  const factory AddRestDayEvent() = _AddRestDayEvent;
}

@freezed
class DeleteRestDayEvent extends RestDayEvent with _$DeleteRestDayEvent {
  const factory DeleteRestDayEvent() = _DeleteRestDayEvent;
}