import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'register_event.freezed.dart';

abstract class RegisterEvent extends BaseBlocEvent {
  const RegisterEvent();
}
@freezed
class InitialRegister extends RegisterEvent with _$InitialRegister {
  const factory InitialRegister() = _InitialRegister;
}

@freezed
class EmailTextFieldChanged extends RegisterEvent with _$EmailTextFieldChanged {
  const factory EmailTextFieldChanged({
    required String email,
  }) = _EmailTextFieldChanged;
}

@freezed
class PasswordTextFieldChanged extends RegisterEvent with _$PasswordTextFieldChanged {
  const factory PasswordTextFieldChanged({
    required String password,
  }) = _PasswordTextFieldChanged;
}
@freezed
class ConfirmPasswordChangeed extends RegisterEvent with _$ConfirmPasswordChangeed {
  const factory ConfirmPasswordChangeed({
    required String confirmpass,
  }) = _ConfirmPasswordChangeed;
}
@freezed
class NameChangeed extends RegisterEvent with _$NameChangeed {
  const factory NameChangeed({
    required String name,
  }) = _NameChangeed;
}

@freezed
class PhoneChange extends RegisterEvent with _$PhoneChange {
  const factory PhoneChange({
    required String phone,
  }) = _PhoneChange;
}

@freezed
class EyeIconPressedPass extends RegisterEvent with _$EyeIconPressedPass {
  const factory EyeIconPressedPass() = _EyeIconPressedPass;
}

@freezed
class EyeIconPressedPassConfirm extends RegisterEvent with _$EyeIconPressedPassConfirm {
  const factory EyeIconPressedPassConfirm() = _EyeIconPressedPassConfirm;
}


@freezed
class RegisterwithFacebook extends RegisterEvent with _$RegisterwithFacebook {
  const factory RegisterwithFacebook() = _RegisterwithFacebook;
}

@freezed
class RegisterwithGoogle extends RegisterEvent with _$RegisterwithGoogle {
  const factory RegisterwithGoogle() = _RegisterwithGoogle;
}

@freezed
class RegisterButtonPress extends RegisterEvent with _$RegisterButtonPress {
  const factory RegisterButtonPress() = _RegisterButtonPress;
}



// @freezed
// class FakeRegisterwithFacebook extends LoginEvent with _$FakeRegisterwithFacebook {
//   const factory FakeRegisterwithFacebook() = _FakeRegisterwithFacebook;
// }
