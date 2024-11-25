import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../data.dart';

import 'model/api_shop_response.dart';

@LazySingleton()
class AppApiShop {
  AppApiShop(
    this._getShopListApiClient,
    this._createShopApiClient
  );

  final GetShopListApiClient _getShopListApiClient;
  final CreateShopApiClient _createShopApiClient;

  Future<DataListResponse<ApiGetShopResponseData>?> getshoplist({
    required String token
  }) async {
    return await _getShopListApiClient.request(
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'accept':'application/json'
        },
      ),
      method: RestMethod.get,
      path: '/shops/owner',
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      decoder: (json) =>
          ApiGetShopResponseData.fromJson(json as Map<String, dynamic>),
    );
  }
Future<DataResponse<ApiGetShopResponseData>?> createShop({    
required String shopName,
    required String phone,
    required String address,
    required String email,
    required String open,
    required String close,
    required String token
  }) async {
    final FormData formData = FormData.fromMap({
    'shop_name': shopName,
    'address': address,
    'phone': phone,
    'email': email,
    'open': open,
    'close': close,
  });
    return await _createShopApiClient.request(
      method: RestMethod.post,
      path: '/shops',
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Content-Type': 'multipart/form-data',
          'Authorization':'Bearer $token'
        },
      ),
      body: formData,
      decoder: (json) => ApiGetShopResponseData.fromJson(json as Map<String, dynamic>),
    );
  }
  Future<Object?> deleteShop({    
  required String id,
  required String token
  }) async {
    // var result =  await _createShopApiClient.request(
    //   method: RestMethod.delete,
    //   path: '/shops/$id',
    //   successResponseMapperType: SuccessResponseMapperType.jsonObject,
    //   options: Options(
    //     headers: {
    //       'accept': 'application/json',
    //       'Authorization':'Bearer $token'
    //     },
    //   ),
    // );
    // print('result: $result' );
    return await _createShopApiClient.request(
      method: RestMethod.delete,
      path: '/shops/$id',
      successResponseMapperType: SuccessResponseMapperType.jsonObject,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization':'Bearer $token'
        },
      ),
    );
  }


  Future<DataResponse<ApiGetShopResponseData>?> updateShop(
      {
      required String shopName,
      required String id,
      required String phone,
    required String address,
    required String email,
    required String open,
    required String close,
    required String token}) async {
    final FormData formData = FormData.fromMap({
    'shop_name': shopName,
    'address': address,
    'phone': phone,
    'email': email,
    'open': open,
    'close': close,
    });
    return await _createShopApiClient.request(
      method: RestMethod.patch,
      path: '/shops/$id',
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
          ApiGetShopResponseData.fromJson(json as Map<String, dynamic>),
    );
  }
}
