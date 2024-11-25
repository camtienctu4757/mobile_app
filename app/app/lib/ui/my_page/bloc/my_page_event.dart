
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../app.dart';

part 'my_page_event.freezed.dart';

abstract class MyPageEvent extends BaseBlocEvent {
  const MyPageEvent();
}

@freezed
class MyPagePageInitiated extends MyPageEvent with _$MyPagePageInitiated {
  const factory MyPagePageInitiated({
    required int id,
  }) = _MyPagePageInitiated;
}

@freezed
class LogoutButtonPressed extends MyPageEvent with _$LogoutButtonPressed {
  const factory LogoutButtonPressed() = _LogoutButtonPressed;
}

@freezed
class IsLogin extends MyPageEvent with _$IsLogin {
  const factory IsLogin({
    required bool is_login
  }) = _IsLogin;
}


@freezed
class LogoutButtonPress extends MyPageEvent with _$LogoutButtonPress {
  const factory LogoutButtonPress() = _LogoutButtonPress;
}
