// screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:shared/shared.dart';
import '../../app.dart';
import 'bloc/setting.dart';

@RoutePage()
class SettingSwitchPage extends StatefulWidget {
  const SettingSwitchPage({super.key});

  @override
  State<SettingSwitchPage> createState() => _SettingSwitchPageState();
}

class _SettingSwitchPageState extends BasePageState<SettingSwitchPage, SettingBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            BlocBuilder<AppBloc, AppState>(
              buildWhen: (previous, current) =>
                  previous.isDarkTheme != current.isDarkTheme,
              builder: (context, state) {
                return SwitchListTile.adaptive(
                    activeColor: ColorConstant.secondary,
                    inactiveThumbColor: ColorConstant.textbacklight,
                    shape: null,
                    title: Text(
                      S.current.darkTheme,
                      style: state.isDarkTheme?AppTextStyles.s16w400White(): AppTextStyles.s16w500Normal(),
                    ),
                    // tileColor: AppColors.current.primaryColor,
                    value: state.isDarkTheme,
                    onChanged: (isDarkTheme) => context.read<AppBloc>().add(
                          AppThemeChanged(isDarkTheme: isDarkTheme),
                        ));
              },
            ),
            BlocBuilder<AppBloc, AppState>(
              buildWhen: (previous, current) =>
                  previous.languageCode != current.languageCode,
              builder: (context, state) {
                return SwitchListTile.adaptive(
                    activeColor: ColorConstant.secondary,
                    inactiveThumbColor: ColorConstant.textbacklight,
                    shape: null,
                    title: Text(
                      S.current.vietnamese,
                      style: state.isDarkTheme? AppTextStyles.s16w400White(): AppTextStyles.s16w500Normal(),
                    ),
                    // tileColor: AppColors.current.primaryColor,
                    value: state.languageCode == LanguageCode.vi,
                    onChanged: (isJa) => context.read<AppBloc>().add(
                          AppLanguageChanged(
                              languageCode:
                                  isJa ? LanguageCode.vi : LanguageCode.en),
                        ));
              },
            ),
            SizedBox(height: Dimens.d15.responsive()),
            // ElevatedButton(
            //   onPressed: () => bloc.add(const LogoutButtonPressed()),
            //   style: ButtonStyle(
            //     backgroundColor:
            //         MaterialStateProperty.all(ColorConstant.bg_button_primary),
            //   ),
            //   child: Text(
            //     S.current.logout,
            //     style: AppTextStyles.s16w600White(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
