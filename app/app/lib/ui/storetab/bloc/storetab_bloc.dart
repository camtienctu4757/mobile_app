import 'storetab.dart';
import 'package:injectable/injectable.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/app.dart';
import 'package:domain/domain.dart';
import 'dart:typed_data';
import 'package:get_it/get_it.dart';

@Injectable()
class StoreBloc extends BaseBloc<StoreEvent, StoreState> {
  StoreBloc(this._loadShopListUsecase, this._getLocalUserUseCase,
      this._getImageUseCase, this._deleteShopUseCase)
      : super(const StoreState()) {
    logD("StoreBloc created with hashCode: ${this.hashCode}");
    on<StoreTabInitiated>(_onStoreTabInitiated);
    on<LoadShopImage>(_onLoadShopImage);
    on<DeleteShop>(_onDeleteShop);
    // on<AddImgList>(_onAddImgList);
  }

// @lazySingleton
// class StoreBloc extends BaseBloc<StoreEvent, StoreState> {
//   StoreBloc(
//     this._loadShopListUsecase,
//     this._getLocalUserUseCase,
//     this._getImageUseCase,
//   ) : super(const StoreState()) {
//     print("StoreBloc created with hashCode: ${this.hashCode}");
//     on<StoreTabInitiated>(_onStoreTabInitiated);
//     on<LoadShopImage>(_onLoadShopImage);
//   }

  final GetShopsUseCase _loadShopListUsecase;
  final GetLocalUserUseCase _getLocalUserUseCase;
  final GetImageShopUseCase _getImageUseCase;
  final DeleteShopUseCase _deleteShopUseCase;

  Future<void> _onStoreTabInitiated(
      StoreTabInitiated event, Emitter<StoreState> emit) async {
    logD("calling initiated store");
    final userOut =
        await _getLocalUserUseCase.execute(const GetLocalUserInput());
    if (userOut.user != null) {
      try {
        final shopList =
            await _loadShopListUsecase.execute(const GetShopInput());
        if (shopList.shops.isNotEmpty) {
          emit(state.copyWith(
            getShopSuccess: true,
            StoreLoadingState: false,
            loadShopList: shopList.shops,
          ));
        } else {
          emit(state.copyWith(
            StoreLoadingState: false,
            getShopSuccess: false,
          ));
        }
      } catch (e) {
        print("Unhandled error: $e");
      }
    }
  }

  Future<void> _onDeleteShop(DeleteShop event, Emitter<StoreState> emit) async {
    try {
    logD("calling deleteshop");
      await _deleteShopUseCase.execute(DeleteShopInput(shopId: event.shopId));
    } catch (e) {
      logD("Error delete shop: $e");
    }
  }

  Future<void> _onLoadShopImage(
      LoadShopImage event, Emitter<StoreState> emit) async {
    try {
      if (event.queryParameters?['shop_id'] != null) {
        final imageData = await _getImageUseCase
            .execute(GetImageShopInput(queryParameters: event.queryParameters));
        if (imageData.image != null && imageData.image!.isNotEmpty) {
          emit(state.copyWith(
            imageData: imageData.image,
          ));
          final updatedShopImages =
              Map<String, Uint8List>.from(state.shopImages)
                ..[event.queryParameters?['shop_id']] = imageData.image!;
          emit(state.copyWith(
            shopImages: updatedShopImages,
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
