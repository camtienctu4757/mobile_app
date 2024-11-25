import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_state.dart';
import 'dart:typed_data';
import 'package:domain/domain.dart';
part 'account_state.freezed.dart';


@freezed
class AccountState extends BaseBlocState with _$AccountState {
  const AccountState._();

  const factory AccountState({
  @Default(null) User? user, 
  @Default(false) bool LogoutSuccess,
  Uint8List? imageData,
  }) = _AccountState;

}