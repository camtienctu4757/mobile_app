import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../data.dart';

@LazySingleton()
class AppApiProduct {
  AppApiProduct(this._createServiceApiClient);

  final CreateServiceApiClient _createServiceApiClient;
  Future<DataResponse<ApiServiceItemData>?> CreateService(
      {required String name,
      required String description,
      required String style,
      required double price,
      required int duration,
      required int employee,
      required String token,
      required String shopId}) async {
    final FormData formData = FormData.fromMap({
      'name': name,
      'description': description,
      'style': style,
      'price': price.toString(),
      'shop_id': shopId,
      'duration': duration,
      'employee': employee.toString
    });
    return await _createServiceApiClient.request(
      method: RestMethod.post,
      path: '/products',
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $token'
        },
      ),
      body: formData,
      decoder: (json) =>
          ApiServiceItemData.fromJson(json as Map<String, dynamic>),
    );
  }
  
  Future<Object?> deleteService({    
  required String id,
  required String token
  }) async {
    return await _createServiceApiClient.request(
      method: RestMethod.delete,
      path: '/products/$id',
      successResponseMapperType: SuccessResponseMapperType.jsonObject,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization':'Bearer $token'
        },
      ),
    );
  }

    Future<DataResponse<ApiServiceItemData>?> updateService(
      {required String name,
      required String id,
      required String description,
      required double price,
      required int duration,
      required int employee,
      required String token,
      required String shopId}) async {
    final FormData formData = FormData.fromMap({
      'name': name,
      'description': description,
      'price': price.toString(),
      'shop_id': shopId,
      'employee': employee.toString
    });
    return await _createServiceApiClient.request(
      method: RestMethod.put,
      path: '/products/$id',
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $token'
        },
      ),
      body: formData,
      decoder: (json) =>
          ApiServiceItemData.fromJson(json as Map<String, dynamic>),
    );
  }
}
