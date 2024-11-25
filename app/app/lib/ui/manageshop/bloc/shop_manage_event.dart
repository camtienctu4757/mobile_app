import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/app.dart';

part 'shop_manage_event.freezed.dart';

abstract class ShopManageEvent extends BaseBlocEvent {
  const ShopManageEvent();
}

@freezed
class ShopManagePageInitiated extends ShopManageEvent with _$ShopManagePageInitiated {
  const factory ShopManagePageInitiated() = _ShopManagePageInitiated;
}

@freezed
class LoadShopImage extends ShopManageEvent with _$LoadShopImage {
  const factory LoadShopImage({required Map<String, dynamic>? queryParameters}) = _LoadShopImage;
}


@freezed
class UpdateBookingSuccess extends ShopManageEvent with _$UpdateBookingSuccess {
  const factory UpdateBookingSuccess({required String id}) = _UpdateBookingSuccess;
}


@freezed
class UpdateBookingCancle extends ShopManageEvent with _$UpdateBookingCancle {
  const factory UpdateBookingCancle({required String id}) = _UpdateBookingCancle;
}

