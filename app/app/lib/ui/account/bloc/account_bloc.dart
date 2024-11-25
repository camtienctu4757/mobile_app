import 'dart:async';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../app.dart';
import 'account.dart';
import 'dart:typed_data';

@Injectable()
class AccountBloc extends BaseBloc<AccountEvent, AccountState> {
  AccountBloc(this._logoutUseCase, this._getImageUseCase, this._getUsersUseCase)
      : super(const AccountState()) {
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
    // on<LogoutButtonPressed>(_onLogoutButtonPressed);
    on<UserLoadImage>(_onUserLoadImage);
    on<LoadUserInfo>(_onLoadUserInfo);
  }
  final LogoutUseCase _logoutUseCase;
  final GetImageUserUseCase _getImageUseCase;
  final GetUsersUseCase _getUsersUseCase;
  FutureOr<void> _onLogoutButtonPressed(
    LogoutButtonPressed event,
    Emitter<AccountState> emit,
  ) async {
    return runBlocCatching(
      action: () async {
        await _logoutUseCase.execute(const LogoutInput());
        emit(state.copyWith(LogoutSuccess: true));
      },
    );
  }

  Future<void> _onUserLoadImage(
      UserLoadImage event, Emitter<AccountState> emit) async {
    try {
      final imageData = await _getImageUseCase
          .execute(GetImageUserInput(queryParameters: event.queryParameters));
      print(imageData);
      if (imageData.image != null && imageData.image!.isNotEmpty) {
        emit(state.copyWith(
          imageData: imageData.image,
        ));
      } else {
        emit(state.copyWith(
          imageData: Uint8List.fromList([]),
        ));
      }
    } catch (error) {
      logD("Error loading image: $error");
    }
  }

  Future<void> _onLoadUserInfo(
      LoadUserInfo event, Emitter<AccountState> emit) async {
    try {
      final userout = await _getUsersUseCase.execute(const GetUsersInput());
      if (userout.user != null) {
        emit(state.copyWith(
          user: userout.user,
        ));
      }
    } catch (error) {
      logD("Error loading image: $error");
    }
  }
}
