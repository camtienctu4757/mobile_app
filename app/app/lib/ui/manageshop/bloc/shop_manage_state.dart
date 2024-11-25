import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../base/bloc/base_bloc_state.dart';
import 'dart:typed_data';
part 'shop_manage_state.freezed.dart';

@freezed
class ShopManageState extends BaseBlocState with _$ShopManageState {
  const ShopManageState._();

  const factory ShopManageState({
  Uint8List? imageData,
  @Default(false) isUpdateCancle,
  @Default(false) isUpdateSuccess,
  @Default(<AppointmentItem>[]) List<AppointmentItem?> listBooking
  }) = _ShopManageState;

}