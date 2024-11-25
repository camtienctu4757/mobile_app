import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_state.dart';

part 'register_state.freezed.dart';

@freezed
class RegisterState extends BaseBlocState with _$RegisterState {
  const factory RegisterState({
    @Default('') String email,
    @Default('') String password,
    @Default('') String confirmpassword,
    @Default('') String phone,
    @Default('') String username,
    @Default(false) bool isRegisterButtonEnabled,
    @Default(false) bool obscurepassword,
    @Default(false) bool obscureconfirm,
    @Default('') String onPageError,
    @Default(false) bool showRegisterButtonLoading,
    @Default(false) bool onGoogleRegister,
    @Default(false) bool onFacebookRegister,
    @Default('') String emailError,
    @Default('') String nameError,
    @Default('') String phoneError,
    @Default('') String passError,
    @Default('') String confirmError,
  }) = _RegisterState;
}
