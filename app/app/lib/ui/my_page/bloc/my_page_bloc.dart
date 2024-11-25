import 'dart:async';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../app.dart';
import 'my_page.dart';

@Injectable()
class MyPageBloc extends BaseBloc<MyPageEvent, MyPageState> {
  MyPageBloc(this._logoutUseCase) : super(const MyPageState()) {
    on<IsLogin>(_onLogin);
    on<LogoutButtonPress>(_onLogoutButtonPress);
  }

  Future<void> _onLogin(IsLogin event, Emitter<MyPageState> emit) async {
    if (event.is_login == false) {
      emit(state.copyWith(ShowLoginButton: true));
    } else {
      emit(state.copyWith(ShowLoginButton: false));
    }
  }

  final LogoutUseCase _logoutUseCase;

  Future<void> _onLogoutButtonPress(
      LogoutButtonPress event, Emitter<MyPageState> emit) async {
    await _logoutUseCase.execute(const LogoutInput());
  }
}
