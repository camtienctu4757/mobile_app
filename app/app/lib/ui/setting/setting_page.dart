// screens/settings_screen.dart
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'bloc/setting.dart';
import 'package:resources/resources.dart';
import 'package:auto_route/auto_route.dart';
import 'package:app/app.dart';

@RoutePage()
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends BasePageState<SettingPage, SettingBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: ButtonBack(),
          title: Text(
            S.current.setting,
            style: AppTextStyles.s18w600Primary(),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.notifications,
                  color: ColorConstant.icon_primary),
              title: Text(S.current.notification),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: ColorConstant.primary_alpha),
              onTap: () {
                Navigator.pushNamed(context, '/notification');
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.lock, color: ColorConstant.icon_primary),
              title: Text(S.current.passwordchange),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: ColorConstant.primary_alpha,
              ),
              onTap: () {},
            ),
            ListTile(
              leading:
                  const Icon(Icons.delete, color: ColorConstant.icon_primary),
              title: Text(S.current.deleteaccount),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: ColorConstant.primary_alpha),
              onTap: () {},
            ),
            ListTile(
              leading:
                  const Icon(Icons.settings, color: ColorConstant.icon_primary),
              title: Text(S.current.setting),
              trailing: const Icon(Icons.arrow_forward_ios,
                  color: ColorConstant.primary_alpha),
              onTap: () {
                navigator.push(AppRouteInfo.settingSwitch());
              },
            )
          ],
        ),
      ),
    );
  }
}
