import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../../app.dart';

// ignore_for_file:prefer-single-widget-per-file
@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
@LazySingleton()
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: SettingRoute.page),
        AutoRoute(page: MainRoute.page, children: [
          AutoRoute(
            page: HomeTab.page,
            // maintainState: true,
            children: [
              AutoRoute(page: HomeRoute.page, initial: true),
              AutoRoute(
                page: ItemDetailRoute.page,
                // guards: [RouteGuard(GetIt.instance.get<IsLoggedInUseCase>())],
              ),
              AutoRoute(
                page: BookingRoute.page,
                
                // RouteGuard(GetIt.instance.get<IsLoggedInUseCase>())
              ),
              AutoRoute(page: ConfirmationRoute.page),
            
            ],
          ),
          AutoRoute(
            page: MyPageTab.page,
            // maintainState: true,
            children: [
              AutoRoute(page: MyPageRoute.page, initial: true),
              AutoRoute(page: SettingRoute.page),
              AutoRoute(page: ProfileRoute.page),
              AutoRoute(page: RegisterRoute.page),
              AutoRoute(page: SettingSwitchRoute.page)
            ],
          ),
          AutoRoute(
            page: NotificationTab.page,
            maintainState: true,
            children: [
              AutoRoute(page: NotificationRoute.page, initial: true),
            ],
          ),
          AutoRoute(
            page: AppointmentTab.page,
            // maintainState: true,
            children: [
              AutoRoute(page: AppointmentRoute.page, initial: true),
            ],
          ),
          // AutoRoute(
          //   page: StoreTab.page,
          //   maintainState: true,
          //   children: [
          //     AutoRoute(page: StoreRoute.page, initial: true),
          //     AutoRoute(page: MyShopListRoute.page),
          //     AutoRoute(page: RegisterStoreRoute.page),
          //     AutoRoute(page: ShopManageRoute.page),
          //     AutoRoute(page: ServiceManageRoute.page)
          //   ],
          // ),
          AutoRoute(
            page: StoreTab.page,
            maintainState: true,
            children: [
              AutoRoute(
                page: StoreRoute.page,
                initial: true,
              ),
              AutoRoute(page: MyShopListRoute.page),
              AutoRoute(page: RegisterStoreRoute.page),
              AutoRoute(page: ShopManageRoute.page),
              AutoRoute(page: ServiceManageRoute.page),
              AutoRoute(page: AddServiceRoute.page)
            ],
          )
        ]),
      ];
}

@RoutePage(name: 'HomeTab')
class HomeTabPage extends AutoRouter {
  const HomeTabPage({super.key});
}

@RoutePage(name: 'MyPageTab')
class MyPageTabPage extends AutoRouter {
  const MyPageTabPage({super.key});
}

@RoutePage(name: 'AppointmentTab')
class AppointmentTabPage extends AutoRouter {
  const AppointmentTabPage({super.key});
}

@RoutePage(name: 'NotificationTab')
class NotificationTabPage extends AutoRouter {
  const NotificationTabPage({super.key});
}

@RoutePage(name: 'StoreTab')
class StoreTabPage extends AutoRouter {
  const StoreTabPage({super.key});
}

// @RoutePage(name:'Appointment')
// class  BookingPage extends AutoRouter{
//   const BookingPage({super.key});
  
// }