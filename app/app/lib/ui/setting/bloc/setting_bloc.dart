// blocs/settings_bloc.dart
import 'package:app/app.dart';
import 'setting.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SettingBloc extends BaseBloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingState()) {}
}
