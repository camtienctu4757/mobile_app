import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/app.dart';
part 'restday_state.freezed.dart';

@freezed
class RestDayState extends BaseBlocState with _$RestDayState {
  const RestDayState._();
  const factory RestDayState() = _RestDayState;
}
