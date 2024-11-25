import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:shared/shared.dart';
import '../../../../../data.dart';

@LazySingleton()
class GetShopListApiClient extends RestApiClient {
  GetShopListApiClient()
      : super(
          dio: DioBuilder.createDio(
            options: BaseOptions(baseUrl: UrlConstants.appApiBaseUrl),
          ),
        );
}
