import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'account_event.freezed.dart';

abstract class AccountEvent extends BaseBlocEvent {
  const AccountEvent();
}

@freezed
class AccountPageInitiated extends AccountEvent with _$AccountPageInitiated {
  const factory AccountPageInitiated({
    required User user,
  }) = _AccountPageInitiated;
}

@freezed
class LogoutButtonPressed extends AccountEvent with _$LogoutButtonPressed {
  const factory LogoutButtonPressed() = _LogoutButtonPressed;
}

@freezed
class UserLoadImage extends AccountEvent with _$UserLoadImage {
  const factory UserLoadImage({required Map<String, dynamic>? queryParameters}) = _UserLoadImage;
}
@freezed
class LoadUserInfo extends AccountEvent with _$LoadUserInfo {
  const factory LoadUserInfo() = _LoadUserInfo;
}