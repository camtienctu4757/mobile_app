import 'package:freezed_annotation/freezed_annotation.dart';
part 'shop.freezed.dart';

@freezed
class Shop with _$Shop {
  const factory Shop(
      {@Default(Shop.defaultId) String id,
      @Default(Shop.defaultName) String name,
      @Default(Shop.defaultAddress) String address,
      @Default(Shop.defaultEmail) String email,
      @Default(Shop.defaultPhone) String phone,
      @Default(Shop.defaultOpenEpoch) String open,
      @Default(Shop.defaultCloseEpoch) String close,
      
      }) = _Shop;

  static const defaultId = '';
  static const defaultName = 'camtien';
  static const defaultAddress = 'camtien';
  static const defaultEmail = 'example@example.com';
  static const defaultPhone = '0902176543';
  static const defaultOpenEpoch = '';
  static const defaultCloseEpoch = '';
}
