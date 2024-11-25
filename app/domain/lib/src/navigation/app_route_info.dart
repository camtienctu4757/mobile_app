import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain.dart';

part 'app_route_info.freezed.dart';

/// page
@freezed
class AppRouteInfo with _$AppRouteInfo {
  const factory AppRouteInfo.login() = _Login;
  const factory AppRouteInfo.main() = _Main;
  const factory AppRouteInfo.itemDetail(ServiceItem service) = _ServiceDetail;
  const factory AppRouteInfo.appointbook(ServiceItem service) =
      _AppointmentBook;
  const factory AppRouteInfo.appointconform(
      ServiceItem service, Map<String, Object> timeslot) = _AppointmentConform;
  const factory AppRouteInfo.profile(User? user,   Uint8List? imageData) = _Profile;
  const factory AppRouteInfo.register() = _Register;
  const factory AppRouteInfo.setting() = _Setting;
  const factory AppRouteInfo.settingSwitch() = _SettingSwitch;
  const factory AppRouteInfo.shopmanage(Shop shop, Uint8List? image) = _Shopmanage;
  const factory AppRouteInfo.myshoplist() = _Myshoplist;
  const factory AppRouteInfo.registerShop() = _RegisterShop;
  const factory AppRouteInfo.servicemanage(String shopId) = _Servicemanage;
  const factory AppRouteInfo.security() = _Security;
  const factory AppRouteInfo.addservice(String shopId) = _AddService;
}
