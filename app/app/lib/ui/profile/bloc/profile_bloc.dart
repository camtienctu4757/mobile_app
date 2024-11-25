import 'dart:async';
import 'package:app/ui/account/bloc/account.dart';
import 'package:app/ui/account/bloc/account_event.dart' as account_event;
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../app.dart';
import 'profile.dart';

@Injectable()
class ProfileBloc extends BaseBloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._updateUserUseCase) : super(const ProfileState()) {
    on<ProfilePageInitiated>(
      _onProfilePageInitiated,
      transformer: log(),
    );
    on<UpdateUserButtonPress>(_onUpdateUserButtonPress);
    on<ChangedName>(_onChangedName);
    on<ChangedEmail>(_onChangedEmail);
    on<ChangedPhone>(_onChangedPhone);

    // on<LoadUserInfo>(_onLoadUserInfo);
    // on<UserLoadImage>(_onUserLoadImage);
  }
  final UpdateUserUseCase _updateUserUseCase;
  FutureOr<void> _onProfilePageInitiated(
      ProfilePageInitiated event, Emitter<ProfileState> emit) async {}

  Future<void> _onUpdateUserButtonPress(
      UpdateUserButtonPress event, Emitter<ProfileState> emit) async {
    final result = await _updateUserUseCase.execute(UpdateUserInput(
      name: event.name,
      phone: event.phone,
      email: event.email,
      id: event.id,
    ));
    emit(state.copyWith(isUpdateSuccess: result.isSuccess));
  }

  FutureOr<void> _onChangedName(ChangedName event, Emitter<ProfileState> emit) {
    print(event.name);
    emit(state.copyWith(name: event.name));
  }

  FutureOr<void> _onChangedEmail(
      ChangedEmail event, Emitter<ProfileState> emit) {
    print(event.email);
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _onChangedPhone(
      ChangedPhone event, Emitter<ProfileState> emit) {
    print(event.phone);
    emit(state.copyWith(phone: event.phone));
  }
}
