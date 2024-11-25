import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:typed_data';
import '../../../base/bloc/base_bloc_event.dart';

part 'profile_event.freezed.dart';

abstract class ProfileEvent extends BaseBlocEvent {
  const ProfileEvent();
}

@freezed
class ProfilePageInitiated extends ProfileEvent with _$ProfilePageInitiated {
  const factory ProfilePageInitiated({
    required User user,
  }) = _ProfilePageInitiated;

}
@freezed
class LoadUserInfo extends ProfileEvent with _$LoadUserInfo {
  const factory LoadUserInfo() = _LoadUserInfo;
}
@freezed
class UserLoadImage extends ProfileEvent with _$UserLoadImage {
  const factory UserLoadImage({required String path, required Map<String, dynamic>? queryParameters}) = _UserLoadImage;
}
@freezed
class ChangedName extends ProfileEvent with _$ChangedName {
  const factory ChangedName({required String name}) = _ChangedName;
}
@freezed
class ChangedPhone extends ProfileEvent with _$ChangedPhone {
  const factory ChangedPhone({required String phone}) = _ChangedPhone;
}
@freezed
class ChangedEmail extends ProfileEvent with _$ChangedEmail {
  const factory ChangedEmail({required String email}) = _ChangedEmail;
}


@freezed
class ChangedImage extends ProfileEvent with _$ChangedImage {
  const factory ChangedImage({required Uint8List image}) = _ChangedImage;
}
@freezed
class UpdateUserButtonPress extends ProfileEvent with _$UpdateUserButtonPress {
  const factory UpdateUserButtonPress({required String name, required String phone, required String email, required String id}) = _UpdateUserButtonPress;
}

