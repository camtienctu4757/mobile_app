import 'package:freezed_annotation/freezed_annotation.dart';
import 'photo.dart';
part 'service_item.freezed.dart';

@freezed
class ServiceItem with _$ServiceItem {
  const factory ServiceItem({
    @Default(ServiceItem.defaultId) String id,
    @Default(ServiceItem.defaultName) String name,
    @Default(ServiceItem.defaultPhotos) List<Photo> photos,
    @Default(ServiceItem.defaultPrice) double price,
    @Default(ServiceItem.defaultDescription) String description,
    @Default(ServiceItem.defaultDuration) int duration,
    @Default(ServiceItem.defaultShopId) String shopId,
    @Default(ServiceItem.defaultEmployee) int employee
  }) = _ServiceItem;



  static const defaultName = '';
  static const defaultPhotos = <Photo>[];
  static const defaultPrice = 0.0;
  static const defaultDescription = '';
  static const defaultId = '';
  static const defaultDuration =0;
  static const defaultShopId = '';
  static const defaultEmployee = 0;
}