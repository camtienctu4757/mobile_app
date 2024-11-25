import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_state.dart';
import 'dart:typed_data';
part 'storetab_state.freezed.dart';

@freezed
class StoreState extends BaseBlocState with _$StoreState {
  const StoreState._();

  const factory StoreState({
  @Default([]) List<Shop> loadShopList,
  @Default(false) bool getShopSuccess,
  @Default('') String ErrorPage,
  @Default(true) bool StoreLoadingState,
  Uint8List? imageData,
  @Default({}) Map<String, Uint8List?> shopImages
  }) = _StoreState;

}