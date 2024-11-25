import 'dart:async';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'manage_service.dart';
import 'package:injectable/injectable.dart';
import 'package:app/app.dart';
import 'dart:typed_data';

// BLoC
@Injectable()
class ServiceManageBloc
    extends BaseBloc<ServiceManageEvent, ServiceManageState> {
  ServiceManageBloc(this._getImageUseCase, this._getServicesByShopUseCase)
      : super(const ServiceManageState()) {
    on<ServiceManagePageInitiated>(
      _onManageServicePageInitiated,
      transformer: distinct(),
    );
  }
  final GetImageUseCase _getImageUseCase;
  final GetServicesByShopUseCase _getServicesByShopUseCase;
  FutureOr<void> _onManageServicePageInitiated(ServiceManagePageInitiated event,
      Emitter<ServiceManageState> emit) async {
    try {
      final servicesList = await _getServicesByShopUseCase
          .execute(GetServiceByShopInput(shopId: event.shop_id));
      if (servicesList.services != null) {
        emit(state.copyWith(
            isLoading: false,
            serviceList: servicesList.services,
            isSuccess: true));
      } else {
        emit(state.copyWith(isLoading: false, isSuccess: false));
      }

      // await runBlocCatching(
      //   action: () async {

      //   },
      //   doOnError: (e) async {
      //     print("error: $e");
      //     emit(state.copyWith(ErrorPage: exceptionMessageMapper.map(e)));
      //   },
      // );
    } catch (e) {
      print("Unhandled error: $e");
    }
  }

  Future<void> _onServiceLoadImage(
      LoadServiceImage event, Emitter<ServiceManageState> emit) async {
    try {
      final imageData = await _getImageUseCase.execute(GetImageInput(
          path: '',
          queryParameters: {
            "file_id": event.image_url.fileUuid,
            "service_id": event.service_id
          }));
      if (imageData.image != null && imageData.image!.isNotEmpty) {
        emit(state.copyWith(serviceImage: imageData.image));
      }
    } catch (error) {
      logD("Error loading image: $error");
    }
  }
}
