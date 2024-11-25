import '../../shared.dart';

class UrlConstants {
  const UrlConstants._();

  /// Url
  static const termUrl = 'https://www.chatwork.com/';
  static const lineApiBaseUrl = 'https://api.line.me/';
  static const twitterApiBaseUrl = 'https://api.twitter.com/';
  static const goongApiBaseUrl = 'https://rsapi.goong.io/';
  static const firebaseStorageBaseUrl =
      'https://firebasestorage.googleapis.com/';

  static const randomUserBaseUrl =
      'https://e4ab8ed6-a716-4141-8106-4c043be0e947.mock.pstmn.io/user';

  static const fakelogin =
      'https://dev/realms/beautiapp/protocol/openid-connect/token';

  static const create = 'https://dev.vn/api/v1/users/create';

  static const getServiceUrl = 'https://dev.vn/api/v1/products';
  static const getServiceImgUrl =
      'https://dev.vn/api/v1/files/service';
  // static const searchServiceUrl = 'http://10.0.2.2:5000/services/search';

  static const mockApiBaseUrl = 'https://api.jsonbin.io/';

  /// Path
  static const remoteConfigPath = '/config/RemoteConfig.json';
  static const settingsPath = '/mypage/settings';

  static String get appApiBaseUrl {
    switch (EnvConstants.flavor) {
      case Flavor.develop:
        // return 'http://api.dev.nals.vn/api';
        // return 'https://e4ab8ed6-a716-4141-8106-4c043be0e947.mock.pstmn.io/service';
        return 'https://dev.vn/api/v1';
      case Flavor.qa:
        return 'http://api.dev.nals.vn/api';
      case Flavor.staging:
        return 'http://api.dev.nals.vn/api';
      case Flavor.production:
        return 'https://dev.vn/api/v1';
    }
  }
}
