import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app.dart';
part 'setting_event.freezed.dart';

abstract class SettingEvent extends BaseBlocEvent {
  const SettingEvent();
}

@freezed
class SettingPageInitiated extends SettingEvent with _$SettingPageInitiated {
  const factory SettingPageInitiated() = _SettingPageInitiated;
}
