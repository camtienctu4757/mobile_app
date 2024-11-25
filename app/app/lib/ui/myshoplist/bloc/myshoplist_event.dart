import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/app.dart';

part 'myshoplist_event.freezed.dart';

abstract class MyShopListEvent extends BaseBlocEvent {
  const MyShopListEvent();
}

@freezed
class MyShopListPageInitiated extends MyShopListEvent with _$MyShopListPageInitiated {
  const factory MyShopListPageInitiated() = _MyShopListPageInitiated;
}

@freezed
class LoadShopError extends MyShopListEvent with _$LoadShopError {
  const factory LoadShopError({
    required String errorMessage,
  }) = _LoadShopError;
}

