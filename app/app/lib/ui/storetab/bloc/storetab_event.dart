// Events
import 'package:app/app.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'storetab_event.freezed.dart';
abstract class StoreEvent extends BaseBlocEvent {}

@freezed
class StoreTabInitiated extends StoreEvent with _$StoreTabInitiated {
  const factory StoreTabInitiated() = _StoreTabInitiated;
}

@freezed
class LoadShopSucess extends StoreEvent with _$LoadShopSucess {
  const factory LoadShopSucess({
    required bool isuccess
  }) = _LoadShopSucess;
}

@freezed
class LoadShopImage extends StoreEvent with _$LoadShopImage {
  const factory LoadShopImage({required Map<String, dynamic>? queryParameters}) = _LoadShopImage;
}

@freezed
class AddImgList extends StoreEvent with _$AddImgList {
  const factory AddImgList({required String shopId}) = _AddImgList;
}

@freezed
class DeleteShop extends StoreEvent with _$DeleteShop {
  const factory DeleteShop({required String shopId}) = _DeleteShop;
}