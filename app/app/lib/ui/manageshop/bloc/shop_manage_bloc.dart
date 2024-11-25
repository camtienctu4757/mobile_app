import 'dart:async';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../app.dart';
import 'shop_manage.dart';
import 'dart:typed_data';

@Injectable()
class ShopManageBloc extends BaseBloc<ShopManageEvent, ShopManageState> {
  ShopManageBloc(this._getImageUseCase, this._shopUpdateBookingCancleUsecase, this._shopUpdateSuccessUseCase) : super(const ShopManageState()) {
    on<LoadShopImage>(_onLoadShopImage);
  }
  final GetImageShopUseCase _getImageUseCase;
  final ShopUpdateBookingCancleUsecase _shopUpdateBookingCancleUsecase;
  final ShopUpdateSuccessUseCase _shopUpdateSuccessUseCase;
  Future<void> _onLoadShopImage(
      LoadShopImage event, Emitter<ShopManageState> emit) async {
    try {
      if (event.queryParameters?['shop_id'] != null) {
        final imageData = await _getImageUseCase
            .execute(GetImageShopInput(queryParameters: event.queryParameters));
        if (imageData.image != null && imageData.image!.isNotEmpty) {
          emit(state.copyWith(
            imageData: imageData.image,
          ));
        } else {
          emit(state.copyWith(
            imageData: Uint8List.fromList([]),
          ));
        }
      }
    } catch (error) {
      logD("Error loading image: $error");
    }
  }
}
