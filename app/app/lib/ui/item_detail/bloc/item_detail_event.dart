import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:domain/domain.dart';
import '../../../base/bloc/base_bloc_event.dart';

part 'item_detail_event.freezed.dart';

abstract class ItemDetailEvent extends BaseBlocEvent {
  const ItemDetailEvent();
}

@freezed
class ItemDetailPageInitiated extends ItemDetailEvent with _$ItemDetailPageInitiated {
  const factory ItemDetailPageInitiated({
    required int id,
  }) = _ItemDetailPageInitiated;
}

@freezed
class ServiceLoad extends ItemDetailEvent with _$ServiceLoad {
  const factory ServiceLoad() = _ServiceLoad;
}

@freezed
class LoadServiceImage extends ItemDetailEvent with _$LoadServiceImage {
  const factory LoadServiceImage({
    required List<Photo> image_url,
    required String service_id
  }) = _LoadServiceImage;
}

@freezed
class LoadShopImage extends ItemDetailEvent with _$LoadShopImage {
  const factory LoadShopImage({
    required String shop_id
  }) = _LoadShopImage;
}

@freezed
class LoadShop extends ItemDetailEvent with _$LoadShop {
  const factory LoadShop({
    required String shop_id
  }) = _LoadShop;
}