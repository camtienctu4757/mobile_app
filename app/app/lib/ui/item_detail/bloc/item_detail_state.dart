import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../base/bloc/base_bloc_state.dart';
import 'package:domain/domain.dart';
import 'dart:typed_data';
part 'item_detail_state.freezed.dart';

@freezed
class ItemDetailState extends BaseBlocState with _$ItemDetailState {
  const factory ItemDetailState(
      {@Default('') String id,
      @Default(LoadMoreOutput<ServiceItem>(data: <ServiceItem>[]))
      LoadMoreOutput<ServiceItem> services,
      @Default(false) bool isShimmerLoading,
      @Default([]) List<Uint8List>? ImageServiceList,
      Uint8List? ShopImage,
      Shop? shop
      }) = _ItemDetailState;
}
