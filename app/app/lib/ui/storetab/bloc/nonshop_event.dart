// Events
import 'package:app/app.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'nonshop_event.freezed.dart';
abstract class NonShopEvent extends BaseBlocEvent {}

@freezed
class NonShopInitiated extends NonShopEvent with _$NonShopInitiated {
  const factory NonShopInitiated() = _NonShopInitiated;
}

