import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

import '../../app.dart';

@LazySingleton(as: BaseRouteInfoMapper)
class AppRouteInfoMapper extends BaseRouteInfoMapper {
  @override
  PageRouteInfo map(AppRouteInfo appRouteInfo) {
    return appRouteInfo.when(
      login: () => const LoginRoute(),
      main: () => const MainRoute(),
      itemDetail: (service) => ItemDetailRoute(service: service),
      appointbook: (service) => BookingRoute(service:service),
      appointconform:(service, timeslot) => ConfirmationRoute(service: service, timeslot: timeslot),
      profile: (user,img) => ProfileRoute(user:user,imageData:img),
      register: () => const RegisterRoute(),
      setting: () => const SettingRoute(),
      settingSwitch: () => const SettingSwitchRoute(),
      myshoplist: () =>const MyShopListRoute(),
      shopmanage: (shop,image) => ShopManageRoute(shop:shop),
      registerShop: () => const RegisterStoreRoute(),
      // mapSelected:()=>const AddressSelectionRoute(),
      servicemanage: (shopId) => ServiceManageRoute(shopId:shopId),
      security:() => const PolicyRoute(),
      addservice:(shopId) => AddServiceRoute(shopId:shopId),
    );
  }
}
