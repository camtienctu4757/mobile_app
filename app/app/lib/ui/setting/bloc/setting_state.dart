import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'setting_state.freezed.dart';

@freezed
class SettingState extends BaseBlocState with _$SettingState {
  const SettingState._();

  const factory SettingState() = _SettingState;

}
