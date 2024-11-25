import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:flutter/services.dart';
import '../../app.dart';
import 'bloc/main.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends BasePageState<MainPage, MainBloc> {
  final _bottomBarKey = GlobalKey();

  @override
  Widget buildPage(BuildContext context) {
    // return AutoTabsScaffold(
    //   routes: (navigator as AppNavigatorImpl).tabRoutes,
    //   bottomNavigationBuilder: (_, tabsRouter) {
    //     (navigator as AppNavigatorImpl).tabsRouter = tabsRouter;
    //     return BottomNavigationBar(
    //       key: _bottomBarKey,
    //       currentIndex: tabsRouter.activeIndex,
    //       onTap: (index) {
    //         if (index == tabsRouter.activeIndex) {
    //           (navigator as AppNavigatorImpl).popUntilRootOfCurrentBottomTab();
    //         }
    //         tabsRouter.setActiveIndex(index);
    //       },
    //       showSelectedLabels: true,
    //       showUnselectedLabels: true,
    //       unselectedItemColor: ColorConstant.unselectedItemColor,
    //       selectedItemColor: AppColors.current.primaryColor,
    //       type: BottomNavigationBarType.fixed,
    //       backgroundColor: ColorConstant.white,
    //       items: BottomTab.values
    //           .map(
    //             (tab) => BottomNavigationBarItem(
    //               label: tab.title,
    //               icon: tab.icon,
    //               activeIcon: tab.activeIcon,
    //             ),
    //           )
    //           .toList(),
    //     );
    //   },
    // );

    return PopScope(
      canPop: (navigator as AppNavigatorImpl).tabsRouter?.activeIndex == 0,
      onPopInvoked: (didPop) {
        if ((navigator as AppNavigatorImpl).tabsRouter?.activeIndex != 0) {
          (navigator as AppNavigatorImpl).tabsRouter?.setActiveIndex(0);
        } else {
          SystemNavigator.pop();
        }
      },
      child: AutoTabsScaffold(
        routes: (navigator as AppNavigatorImpl).tabRoutes,
        bottomNavigationBuilder: (_, tabsRouter) {
          (navigator as AppNavigatorImpl).tabsRouter = tabsRouter;

          return BottomNavigationBar(
            key: _bottomBarKey,
            currentIndex: tabsRouter.activeIndex,
            onTap: (index) {
              (navigator as AppNavigatorImpl).popUntilRootOfCurrentBottomTab();

              tabsRouter.setActiveIndex(index);
            },
            showSelectedLabels: true,
            showUnselectedLabels: true,
            unselectedItemColor: ColorConstant.unselectedItemColor,
            selectedItemColor: AppColors.current.primaryColor,
            type: BottomNavigationBarType.fixed,
            backgroundColor: ColorConstant.white,
            items: BottomTab.values
                .map(
                  (tab) => BottomNavigationBarItem(
                    label: tab.title,
                    icon: tab.icon,
                    activeIcon: tab.activeIcon,
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
