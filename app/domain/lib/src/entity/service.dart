import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'service.freezed.dart';

@freezed
class Service with _$Service {
  const factory Service({
    @Default(Service.defaultName) String name,
    @Default(Service.defaultPhotos) List<ImageUrl> photos,
    @Default(Service.defaultPrice) double price,
  }) = _Service;

  static const defaultName = '';
  static const defaultPhotos = <ImageUrl>[];
  static const defaultPrice = 0.0;
  static const defaultDescription = '';
}