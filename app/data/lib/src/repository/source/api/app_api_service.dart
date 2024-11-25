import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../data.dart';
import 'dart:typed_data';

@LazySingleton()
class AppApiService {
  AppApiService(
      this._noneAuthAppServerApiClient,
      this._authAppServerApiClient,
      this._randomUserApiClient,
      this._getServiceApiClient,
      this._searchApiClient,
      this._getImageServiceApiClient,
      this._userBaseApiClient,
      this._getMeApiClient);
  final NoneAuthAppServerApiClient _noneAuthAppServerApiClient;
  final AuthAppServerApiClient _authAppServerApiClient;
  final RandomUserApiClient _randomUserApiClient;
  final ServiceApiClient _getServiceApiClient;
  final SearchApiClient _searchApiClient;
  final GetMeApiClient _getMeApiClient;
  final GetServiceImgeApiClient _getImageServiceApiClient;
  final UserBaseApiClient _userBaseApiClient;
  Future<ApiAuthResponseData?> login({
    required String email,
    required String password,
  }) async {
    // print(password);
    final Map<String, dynamic> body = {
      'grant_type': 'password',
      'client_id': 'beautiapp',
      'client_secret': const String.fromEnvironment('Client_Secret_KeyCloak'),
      'username': email,
      'password': password,
    };
    return await _authAppServerApiClient.request(
        method: RestMethod.post,
        path: '',
        body: body,
        successResponseMapperType: SuccessResponseMapperType.jsonObject,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        decoder: (json) =>
            ApiAuthResponseData.fromJson(json as Map<String, dynamic>));
  }

  // Future<JsonObjectResponseMapper<ApiGetmeResponseData>?> getme() async {
  //   return _getMeApiClient.request(
  //     options: Options(
  //       headers: {"",""}
  //     ),
  //     method: RestMethod.get,
  //     path: '/users',
  //     successResponseMapperType: SuccessResponseMapperType.jsonObject,
  //     decoder: (json) =>
  //         ApiGetmeResponseData.fromJson(json as Map<String, dynamic>),
  //   );
  // }

  Future<void> logout() async {
    await _authAppServerApiClient.request(
      method: RestMethod.post,
      path: '',
    );
  }

  Future<ApiUserData?> register({
    required String username,
    required String email,
    required String password,
    required String phone,
  }) async {
    return await _noneAuthAppServerApiClient.request(
      method: RestMethod.post,
      path: '/users',
      successResponseMapperType: SuccessResponseMapperType.jsonObject,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      ),
      body: {
        'username': username,
        'phone': phone,
        'email': email,
        'password': password,
      },
      decoder: (json) => ApiUserData.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<void> forgotPassword(String email) async {
    await _noneAuthAppServerApiClient.request(
      method: RestMethod.post,
      path: '/v1/auth/forgot-password',
      body: {
        'email': email,
      },
    );
  }

  Future<void> resetPassword({
    required String token,
    required String email,
    required String password,
  }) async {
    await _noneAuthAppServerApiClient.request(
      method: RestMethod.post,
      path: '/v1/auth/reset-password',
      body: {
        'token': token,
        'email': email,
        'password': password,
        'password_confirmation': password,
      },
    );
  }

  Future<DataResponse<ApiUserData>?> getMe({
    required String accessToken,
  }) async {
    return await _getMeApiClient.request(
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
          'accept': 'application/json'
        },
      ),
      method: RestMethod.get,
      path: '/users',
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
      decoder: (json) => ApiUserData.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<ResultsListResponse<ApiUserData>?> getUsers({
    required int page,
    required int? limit,
  }) {
    return _randomUserApiClient.request(
      method: RestMethod.get,
      path: '',
      queryParameters: {
        'page': page,
        'results': limit,
      },
      successResponseMapperType: SuccessResponseMapperType.resultsJsonArray,
      decoder: (json) => ApiUserData.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<DataListResponse<ApiServiceData>?> getServices() async {
    // final result = await _getServiceApiClient.request(
    //     method: RestMethod.get,
    //     path: '',
    //     successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
    //     decoder: (json) =>
    //         ApiServiceData.fromJson(json as Map<String, dynamic>));
    // print(result);
    return await _getServiceApiClient.request(
        method: RestMethod.get,
        path: '',
        successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
        decoder: (json) =>
            ApiServiceData.fromJson(json as Map<String, dynamic>));
  }

    Future<DataListResponse<ApiServiceData>?> getServicesByShop({required String shopId}) async {
    // final result = await _getServiceApiClient.request(
    //     method: RestMethod.get,
    //     path: '',
    //     successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
    //     decoder: (json) =>
    //         ApiServiceData.fromJson(json as Map<String, dynamic>));
    // print(result);
    return await _getServiceApiClient.request(
        method: RestMethod.get,
        path: '/shop/${shopId}',
        successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
        decoder: (json) =>
            ApiServiceData.fromJson(json as Map<String, dynamic>));
  }

  List<ApiServiceData> decodeApiServiceData(dynamic json) {
    return (json as List<dynamic>)
        .map((item) => ApiServiceData.fromJson(item as Map<String, dynamic>))
        .toList();
  }


  Future<DataListResponse<ApiServiceData>?> searchServices(query) async {
    final result = await _searchApiClient.request(
        method: RestMethod.get,
        queryParameters: {'query': query},
        path: '/products/search',
        successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
        decoder: (json) =>
            ApiServiceData.fromJson(json as Map<String, dynamic>));
    print("result: $result");
    return await _searchApiClient.request(
        method: RestMethod.get,
        queryParameters: {'query': query},
        path: '/products/search',
        successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
        decoder: (json) =>
            ApiServiceData.fromJson(json as Map<String, dynamic>));
  }

  Future<DataListResponse<ApiServiceData>?> getServicesByCatalog(String name) async {
    final result = await _searchApiClient.request(
        method: RestMethod.get,
        queryParameters: {'catalog_name': name},
        path: '/products/catalog',
        successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
        decoder: (json) =>
            ApiServiceData.fromJson(json as Map<String, dynamic>));
    print("result: $result");
    return await _searchApiClient.request(
        method: RestMethod.get,
        queryParameters: {'catalog_name': name},
        path: '/products/catalog',
        successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
        decoder: (json) =>
            ApiServiceData.fromJson(json as Map<String, dynamic>));
  }

  Future<Uint8List?> fetchFileWithRequest({
    required String accessToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _getImageServiceApiClient.fetchImage(
      path: '/files/service',
      queryParameters: queryParameters,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
          'accept': 'application/json'
        },
        responseType: ResponseType.bytes,
      ),
    );
  }

  Future<Uint8List?> fetchUserFile({
    required String accessToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _getImageServiceApiClient.fetchImage(
      path: '/files/user',
      queryParameters: queryParameters,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
          'accept': 'application/json'
        },
        responseType: ResponseType.bytes,
      ),
    );
  }

  Future<Uint8List?> fetchShopFile({
    required String accessToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _getImageServiceApiClient.fetchImage(
      path: '/files/shop',
      queryParameters: queryParameters,
      options: Options(
        headers: {
          'Authorization': 'Bearer $accessToken',
          'accept': 'application/json'
        },
        responseType: ResponseType.bytes,
      ),
    );
  }

  Future<Object?> deleteUser({required String token}) async {
    return await _getMeApiClient.request(
      method: RestMethod.delete,
      path: '/users',
      successResponseMapperType: SuccessResponseMapperType.jsonObject,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ),
    );
  }

  Future<Object?> updateUser({
    required String token,
    required String id,
    required String username,
    required String phone,
    required String email,
  }) async {
    final FormData formData = FormData.fromMap({
      'username': username,
      'phone': phone,
      'email': email,
    });
    final result = await _userBaseApiClient.request(
      method: RestMethod.patch,
      path: '/users/$id',
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $token'
        },
      ),
      body: formData,
      // decoder: (json) =>
      //     ApiUserData.fromJson(json as Map<String, dynamic>),
    );
    return result;
  }
}
