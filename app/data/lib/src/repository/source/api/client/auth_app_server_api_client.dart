import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'dart:io';
import 'package:shared/shared.dart';
import '../../../../../data.dart';

@LazySingleton()
class AuthAppServerApiClient extends RestApiClient {
  AuthAppServerApiClient(
    HeaderInterceptor _headerInterceptor,
    AccessTokenInterceptor _accessTokenInterceptor,
    RefreshTokenInterceptor _refreshTokenInterceptor,
  ) : super(
          dio: DioBuilder.createDio(
            options: BaseOptions(baseUrl: UrlConstants.fakelogin),
            interceptors: [
              // _headerInterceptor,
              // _accessTokenInterceptor,
              // _refreshTokenInterceptor,
            ],
          ),
        );
}

 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}