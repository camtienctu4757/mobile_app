import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:shared/shared.dart';
import '../../../../../../data.dart';

enum RestMethod { get, post, put, patch, delete }

class RestApiClient {
  RestApiClient({
    required this.dio,
    this.errorResponseMapperType =
        ApiClientDefaultSetting.defaultErrorResponseMapperType,
    this.successResponseMapperType =
        ApiClientDefaultSetting.defaultSuccessResponseMapperType,
  });

  final SuccessResponseMapperType successResponseMapperType;
  final ErrorResponseMapperType errorResponseMapperType;
  final Dio dio;

  Future<T?> request<D extends Object, T extends Object>({
    required RestMethod method,
    required String path,
    Map<String, dynamic>? queryParameters,
    Object? body,
    Decoder<D>? decoder,
    SuccessResponseMapperType? successResponseMapperType,
    ErrorResponseMapperType? errorResponseMapperType,
    Options? options,
  }) async {
    assert(
        method != RestMethod.get ||
            (successResponseMapperType ?? this.successResponseMapperType) ==
                SuccessResponseMapperType.plain ||
            decoder != null,
        'decoder must not be null if method is GET');
    try {
      // print(body);
      // print("option: $options");
      // print("path: $path");

      final response = await _requestByMethod(
        method: method,
        path: path.startsWith(dio.options.baseUrl)
            ? path.substring(dio.options.baseUrl.length)
            : path,
        queryParameters: queryParameters,
        body: body,
        options: Options(
          headers: options?.headers,
          contentType: options?.contentType,
          responseType: options?.responseType,
          sendTimeout: options?.sendTimeout,
          receiveTimeout: options?.receiveTimeout,
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );
      print("status: ${response.statusCode}");
      if (response.data == null) {
        return null;
      }
      if (response.statusCode! > 400) {
        _handleError(response);
      }
      // print("-------------------------------");
      // print(response.toString());
      // print("-------------------------------");
      var data = response.data;
      if (data is String) {
        data = jsonDecode(data);
      }
      // else{
      //   _handleError(response);
      // }
      return BaseSuccessResponseMapper<D, T>.fromType(
        successResponseMapperType ?? this.successResponseMapperType,
      ).map(response: data, decoder: decoder);
    } catch (error) {
      Log.e('$error : $path');
      // throw DioExceptionMapper(
      //   BaseErrorResponseMapper.fromType(
      //     errorResponseMapperType ?? this.errorResponseMapperType,
      //   ),
      // ).map(error);
    }
  }

  // Future<Uint8List?> requestFileWithRequest({
  //   required RestMethod method,
  //   required String path,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  // }) async {
  //   try {
  //     final response = await _requestByMethod(
  //       method: method,
  //       path: path,
  //       queryParameters: queryParameters,
  //       options: Options(
  //         responseType: ResponseType.bytes,
  //         headers: options?.headers,
  //       ),
  //     );

  //     if (response != null && response is Uint8List) {
  //       return response;
  //     } else {
  //       throw Exception('Failed to load binary data');
  //     }
  //   } catch (error) {
  //     print('Error fetching file: $error');
  //     return null;
  //   }
  // }

  Future<Uint8List?> fetchImage({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final dio = Dio();
// dio.interceptors.add(InterceptorsWrapper(
//   onRequest: (options, handler) {
//     print("Sending request to: ${options.uri}");
//     print("Method: ${options.method}");
//     print("Headers: ${options.headers}");
//     print("Query Parameters: ${options.queryParameters}");
//     print("Response Type: ${options.responseType}");
//     handler.next(options); // Tiếp tục gửi request
//   },
//   onResponse: (response, handler) {
//     print("Received response: ${response.statusCode}");
//     handler.next(response); // Tiếp tục xử lý response
//   },
//   onError: (DioError error, handler) {
//     print("Request error: ${error.message}");
//     handler.next(error); // Xử lý lỗi
//   },
// ));
    try {
      final response = await dio.get<List<int>>(
        UrlConstants.appApiBaseUrl + path,
        queryParameters: queryParameters,
        options: Options(
          headers: options?.headers,
          responseType: ResponseType.bytes,
          sendTimeout: options?.sendTimeout,
          receiveTimeout: options?.receiveTimeout,
        ),
      );
      if (response.data != null) {
        return Uint8List.fromList(response.data!);
      }
      return null;

    } catch (error) {
      // print(error);
      return null;
      // throw DioExceptionMapper(
      //   BaseErrorResponseMapper.fromType(
      //     errorResponseMapperType ?? this.errorResponseMapperType,
      //   ),
      // ).map(error);
    }
  }

  void _handleError(Response response) {
    final statusCode = response.statusCode;
    final message = response.data?['message'] ?? 'Unknown error occurred';
    final messag_error = response.data['message_error'] ?? '';
    switch (statusCode) {
      case 400:
        throw Exception('Bad Request: $message $messag_error');
      case 401:
        throw Exception('Unauthorized: $message $messag_error');
      case 403:
        throw Exception('Forbidden: $message $messag_error');
      case 404:
        throw Exception('Not Found: $message $messag_error');
      case 500:
        throw Exception('Internal Server Error: $message $messag_error');
      default:
        throw Exception('HTTP $statusCode: $message $messag_error');
    }
  }

  Future<Response<dynamic>> _requestByMethod({
    required RestMethod method,
    required String path,
    Map<String, dynamic>? queryParameters,
    Object? body,
    Options? options,
  }) {
    switch (method) {
      case RestMethod.get:
        return dio.get(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
      case RestMethod.post:
        return dio.post(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
      case RestMethod.patch:
        return dio.patch(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
      case RestMethod.put:
        return dio.put(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
      case RestMethod.delete:
        return dio.delete(
          path,
          data: body,
          queryParameters: queryParameters,
          options: options,
        );
    }
  }
}
