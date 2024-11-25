import 'dart:async';

import 'package:app/ui/my_page/bloc/my_page.dart';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:resources/resources.dart';
import 'package:app/app.dart';
import 'login.dart';

@Injectable()
class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginBloc(this._loginUseCase) : super(const LoginState()) {
    on<EmailTextFieldChanged>(
      _onEmailTextFieldChanged,
      transformer: distinct(),
    );

    on<PasswordTextFieldChanged>(
      _onPasswordTextFieldChanged,
      transformer: distinct(),
    );

    on<LoginButtonPressed>(
      _onLoginButtonPressed,
      transformer: log(),
    );

    on<EyeIconPressed>(
      _onEyeIconPressed,
      transformer: log(),
    );
    on<InitialLogin>(_onInitialLogin, transformer: log());
  }
  final LoginUseCase _loginUseCase;
  bool _isLoginButtonEnabled(String email, String password) {
    return email.isNotEmpty && password.isNotEmpty;
  }

  void _onEmailTextFieldChanged(
      EmailTextFieldChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      email: event.email,
      isLoginButtonEnabled: _isLoginButtonEnabled(event.email, state.password),
      // onPageError: '',
    ));
  }

  void _onPasswordTextFieldChanged(
      PasswordTextFieldChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      password: event.password,
      isLoginButtonEnabled: _isLoginButtonEnabled(state.email, event.password),
      // onPageError: '',
    ));
  }

  FutureOr<void> _onInitialLogin(InitialLogin event, Emitter<LoginState> emit) {
    emit(state.copyWith(
      obscureText: true,
      onPageError: '',
    ));
    // emit(state.copyWith(onPageError: ''));
  }

  FutureOr<void> _onLoginButtonPressed(
      LoginButtonPressed event, Emitter<LoginState> emit) {
    final myPageBloc = GetIt.instance<MyPageBloc>();
    return runBlocCatching(
      action: () async {
        final result = await _loginUseCase
            .execute(LoginInput(email: state.email, password: state.password));
        if (result.isLoggedIn) {
          myPageBloc.add(const IsLogin(is_login: true));
          navigator.replace(const AppRouteInfo.main());
        }
        else{

        emit(state.copyWith(onPageError: S.current.loginUnsuccessful));
        }
      },
      handleError: false,
      doOnError: (e) async {
        emit(state.copyWith(onPageError: S.current.loginUnsuccessful));
      },
    );
  }
  // FutureOr<void> _onFakeLoginButtonPressed(
  //   FakeLoginButtonPressed event,
  //   Emitter<LoginState> emit,
  // ) async {
  //   return runBlocCatching(
  //     action: () async {
  //       await _fakeLoginUseCase.execute(const FakeLoginInput());
  //     },
  //   );
  // }

  void _onEyeIconPressed(EyeIconPressed event, Emitter<LoginState> emit) {
    emit(state.copyWith(obscureText: !state.obscureText));
  }
}
