import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../../../base/bloc/base_bloc_state.dart';
import 'dart:typed_data';
part 'home_state.freezed.dart';

@freezed
class HomeState extends BaseBlocState with _$HomeState {
  factory HomeState({
    @Default(LoadMoreOutput<ServiceItem>(data: <ServiceItem>[])) LoadMoreOutput<ServiceItem> services,
    @Default(false) bool isShimmerLoading,
    @Default('') String selectedCategory,
    AppException? loadUsersException,
    @Default(<ServiceItem>[]) List<ServiceItem> searchResults, 
    @Default(<ServiceItem>[]) List<ServiceItem> categoryProducts, // kết quả tìm kiếm
    Uint8List? imageData,
    @Default('') String errorMessage,
    @Default('') String createbookingMeassage
  }) = _HomeState;
}
