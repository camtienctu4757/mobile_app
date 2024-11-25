import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../app.dart';

part 'my_page_state.freezed.dart';

@freezed
class MyPageState extends BaseBlocState with _$MyPageState {
  const MyPageState._();

  const factory MyPageState({
   @Default(false) bool ShowLoginButton,
   @Default(false) bool Logout
  
  }) = _MyPageState;

}
