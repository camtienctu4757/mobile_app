import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../base/bloc/base_bloc_state.dart';

part 'nonshop_state.freezed.dart';

@freezed
class NonShopState extends BaseBlocState with _$NonShopState {
  const NonShopState._();

  const factory NonShopState() = _NonShopState;

}