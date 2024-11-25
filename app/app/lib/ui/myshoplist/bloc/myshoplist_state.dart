import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app/app.dart';
import 'package:domain/domain.dart';

part 'myshoplist_state.freezed.dart';

@freezed
class MyShopListState extends BaseBlocState with _$MyShopListState {
  const MyShopListState._();

  const factory MyShopListState({
  @Default('') String? ErrorPage,
  @Default([]) List<Shop> loadShopList,
  @Default(false) bool getShopSuccess,
  }) = _MyShopListState;

}