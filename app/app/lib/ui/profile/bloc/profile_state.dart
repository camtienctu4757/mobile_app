import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:typed_data';
import '../../../base/bloc/base_bloc_state.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState extends BaseBlocState with _$ProfileState {
  const ProfileState._();

  const factory ProfileState({
    @Default(null) User? user,
    Uint8List? imageData,
    @Default('') String name,
    @Default('') String phone,
    @Default('') String email,
    @Default(false) bool isUpdateSuccess,
  
  }) = _ProfileState;

}