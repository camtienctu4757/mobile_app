import 'dart:async';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../app.dart';
import 'item_detail.dart';
import 'dart:typed_data';

@Injectable()
class ItemDetailBloc extends BaseBloc<ItemDetailEvent, ItemDetailState> {
  ItemDetailBloc(this._getServicesUseCase, this._getImageUseCase)
      : super(ItemDetailState()) {
    on<ItemDetailPageInitiated>(
      _onItemDetailPageInitiated,
      transformer: log(),
    );
    on<ServiceLoad>(
      _onServiceLoadMore,
      transformer: log(),
    );
    on<LoadServiceImage>(_LoadServiceImage);
  }

  final GetImageUseCase _getImageUseCase;
  FutureOr<void> _onServiceLoadMore(
      ServiceLoad event, Emitter<ItemDetailState> emit) async {
    await _getService(
      emit: emit,
      isInitialLoad: false,
    );
  }

  FutureOr<void> _onItemDetailPageInitiated(
    ItemDetailPageInitiated event,
    Emitter<ItemDetailState> emit,
  ) async {
    await _getService(
        emit: emit,
        isInitialLoad: true,
        doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
        doOnSuccessOrError: () async =>
            emit(state.copyWith(isShimmerLoading: false)));
  }

  final GetServicesUseCase _getServicesUseCase;
  Future<void> _getService({
    required Emitter<ItemDetailState> emit,
    required bool isInitialLoad,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
  }) async {
    return runBlocCatching(
      action: () async {
        emit(state.copyWith());
        final output = await _getServicesUseCase.execute(
            const GetServiceInput(), isInitialLoad);
  
        emit(state.copyWith(services: output));
      },
      doOnError: (e) async {
        emit(state.copyWith());
      },
      doOnSubscribe: doOnSubscribe,
      doOnSuccessOrError: doOnSuccessOrError,
      handleLoading: false,
      maxRetries: 3,
    );
  }

  Future<void> _LoadServiceImage(
      LoadServiceImage event, Emitter<ItemDetailState> emit) async {
    if (event.image_url.isNotEmpty) {
      for (var i = 0; i < event.image_url.length; i++) {
        final imageData = await _getImageUseCase.execute(GetImageInput(
            path: '',
            queryParameters: {
              "file_id": event.image_url[i].fileUuid,
              "service_id": event.service_id
            }));
        if (imageData.image != null && imageData.image!.isNotEmpty) {
          var temp = List<Uint8List>.from(state.ImageServiceList ?? []);
          temp.add(imageData.image!);
          emit(state.copyWith(ImageServiceList: temp));
        }
      }
    }
  }
  // Future<void> _LoadShopImage(
  //     LoadServiceImage event, Emitter<ItemDetailState> emit) async {
  //   if (event.image_url.isNotEmpty) {
     
  //       final imageData = await _getImageUseCase.execute(GetImageInput(
  //           path: '',
  //           queryParameters: {
  //             "file_id": event.image_url[i].fileUuid,
  //             "service_id": event.service_id
  //   }));
  //       if (imageData.image != null && imageData.image!.isNotEmpty) {
  //         var temp = List<Uint8List>.from(state.ImageServiceList ?? []);
  //         temp.add(imageData.image!);
  //         emit(state.copyWith(ImageServiceList: temp));
  //       }
  //     }
  //   }
  // }
}
