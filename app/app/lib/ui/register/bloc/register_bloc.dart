import 'dart:async';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:app/app.dart';
import 'register.dart';
import 'package:shared/shared.dart';
import 'package:resources/resources.dart';

@Injectable()
class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._registerUserCase) : super(const RegisterState()) {
    on<EmailTextFieldChanged>(
      _onEmailTextFieldChanged,
      transformer: distinct(),
    );

    on<PasswordTextFieldChanged>(
      _onPasswordTextFieldChanged,
      transformer: distinct(),
    );

    on<RegisterButtonPress>(
      _onRegisterButtonPressed,
      transformer: log(),
    );

    on<EyeIconPressedPass>(
      _onEyeIconPressedPass,
      transformer: log(),
    );
    on<EyeIconPressedPassConfirm>(
      _onEyeIconPressedPassConfirm,
      transformer: log(),
    );
    on<InitialRegister>(_onInitialRegister);
    on<PhoneChange>(_onPhoneChange);
    on<NameChangeed>(_onNameChangeed);
    on<ConfirmPasswordChangeed>(_onConfirmPasswordChangeed);
  }
  final RegisterAccountUseCase _registerUserCase;
  void _onEmailTextFieldChanged(
      EmailTextFieldChanged event, Emitter<RegisterState> emit) {
    if (ValidationUtils.isValidEmail(event.email)) {
      emit(state.copyWith(emailError: ''));
      emit(state.copyWith(
        email: event.email,
        onPageError: '',
        emailError: '',
        isRegisterButtonEnabled: _isRegisterButtonEnabled(event.email,
            state.password, state.confirmpassword, state.phone, state.username),
      ));
    } else {
      emit(state.copyWith(emailError: S.current.invalidEmail));
    }
  }

  bool _isRegisterButtonEnabled(
    String email,
    String password,
    String confirmpass,
    String phone,
    String username,
  ) {
    return email.isNotEmpty &&
        password.isNotEmpty &&
        confirmpass.isNotEmpty &&
        phone.isNotEmpty &&
        username.isNotEmpty;
  }

  void _onPasswordTextFieldChanged(
      PasswordTextFieldChanged event, Emitter<RegisterState> emit) {
      if(event.password.isEmpty){
        emit(state.copyWith(passError: S.current.empty));
      }
    else{
      emit(state.copyWith(
      password: event.password,
      passError: '',
      isRegisterButtonEnabled: _isRegisterButtonEnabled(state.email,
          event.password, state.confirmpassword, state.phone, state.username),
    ));
    }
  }

  void _onEyeIconPressedPass(
      EyeIconPressedPass event, Emitter<RegisterState> emit) {
    emit(state.copyWith(obscurepassword: !state.obscurepassword));
  }

  void _onEyeIconPressedPassConfirm(
      EyeIconPressedPassConfirm event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      obscureconfirm: !state.obscureconfirm,
    ));
  }

  FutureOr<void> _onRegisterButtonPressed(
      RegisterButtonPress event, Emitter<RegisterState> emit) {
    return runBlocCatching(
      action: () async {
        await _registerUserCase.execute(RegisterAccountInput(
            username: state.username,
            email: state.email,
            password: state.password,
            phone: state.phone));
        await navigator.replace(const AppRouteInfo.login());
      },
      handleError: false,
      doOnError: (e) async {
        emit(state.copyWith(onPageError: exceptionMessageMapper.map(e)));
      },
    );
  }

  void _onPhoneChange(PhoneChange event, Emitter<RegisterState> emit) {
    if (event.phone.isEmpty) {
      emit(state.copyWith(phoneError: S.current.empty));
    }else{
      if (ValidationUtils.isValidPhoneNumber(event.phone)) {
      emit(state.copyWith(
        phoneError: '',
        phone: event.phone,
        onPageError: '',
        isRegisterButtonEnabled: _isRegisterButtonEnabled(state.email,
            state.password, state.confirmpassword, event.phone, state.username),
      ));
    } else {
      emit(state.copyWith(phoneError: S.current.invalidPhoneNumber));
    }
    }
    
  }

  void _onNameChangeed(NameChangeed event, Emitter<RegisterState> emit) {
    if (event.name.isEmpty) {
      emit(state.copyWith(nameError: S.current.empty));
    } else {
      emit(state.copyWith(
        username: event.name,
        nameError: '',
        isRegisterButtonEnabled: _isRegisterButtonEnabled(state.email,
            state.password, state.confirmpassword, state.phone, event.name),
      ));
    }
  }

  void _onConfirmPasswordChangeed(
      ConfirmPasswordChangeed event, Emitter<RegisterState> emit) {
    if (event.confirmpass.isEmpty) {
      emit(state.copyWith(confirmError: S.current.empty));
    } else {
      if (ValidationUtils.isValidConfirmPass(
          event.confirmpass, state.password)) {
        emit(state.copyWith(
          confirmError: '',
          confirmpassword: event.confirmpass,
          onPageError: '',
          isRegisterButtonEnabled: _isRegisterButtonEnabled(state.email,
              state.password, event.confirmpass, state.phone, state.username),
        ));
      } else {
        emit(state.copyWith(confirmError: S.current.passwordsAreNotMatch));
      }
    }
  }

  FutureOr<void> _onInitialRegister(
      InitialRegister event, Emitter<RegisterState> emit) {
    emit(state.copyWith(
      obscureconfirm: true,
      obscurepassword: true,
      onPageError: '',
      confirmError: '',
      emailError: '',
      nameError: '',
      passError: '',
      phoneError: ''
    ));
  }
}
