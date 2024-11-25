import 'package:app/ui/account/bloc/account.dart';
import 'package:app/ui/my_page/bloc/my_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';
import 'package:data/data.dart';
import 'package:get_it/get_it.dart';
import '../../app.dart';
// screens/Account_screen.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/Account.dart';

@RoutePage()
class AccountPage extends StatefulWidget {
  const AccountPage({super.key});
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends BasePageState<AccountPage, AccountBloc> {
  @override
  void initState() {
    super.initState();
    bloc.add(const LoadUserInfo());
    bloc.add(const UserLoadImage(queryParameters: {}));
  }

  // @override
  // void didPopNext() {
  //   // super.didPopNext();
  //   bloc.add(const LoadUserInfo());
  // }

  @override
  Widget buildPage(BuildContext context) {
    // final appPreferences = GetIt.instance<AppPreferences>();
    // String? name = appPreferences.currentUser?.name ?? 'Unknown User';
    // String? email = appPreferences.currentUser?.email ?? 'unknown@example.com';
    bloc.add(const LoadUserInfo());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 35,
        leadingWidth: double.infinity,
        centerTitle: false,
        backgroundColor: ColorConstant.third,
        leading: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            return _buildUserAccountInfo(state.user?.name, state.user?.email);
          },
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              BlocBuilder<AccountBloc, AccountState>(
                buildWhen: (previous, current) => previous.user != current.user,
                builder: (context, state) {
                  return ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: ColorConstant.icon_primary,
                    ),
                    title: Text(S.current.profile),
                    onTap: () {
                      navigator.push(
                          AppRouteInfo.profile(state.user, state.imageData));
                    },
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: ColorConstant.primary_alpha,
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.privacy_tip,
                  color: ColorConstant.icon_primary,
                ),
                title: Text(S.current.policy),
                onTap: () {},
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorConstant.primary_alpha,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings,
                  color: ColorConstant.icon_primary,
                ),
                title: Text(S.current.setting),
                onTap: () {
                  navigator.push(const AppRouteInfo.setting());
                },
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorConstant.primary_alpha,
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: ColorConstant.icon_primary,
                ),
                title: Text(S.current.logout),
                onTap: () {
                  _showLogoutDrawer(context);
                },
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorConstant.primary_alpha,
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildUserAccountInfo(String? name, String? email) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
            if (state.imageData != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: MemoryImage(state.imageData!),
                  ),
                ],
              );
            }
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(ImgConstants.default_user),
                ),
              ],
            );
          }),
          const SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name ?? 'ExampleName',
                style: AppTextStyles.s18w600Black(),
              ),
              Text(
                email ?? 'example@gmail.com',
                style: AppTextStyles.s20w500Cookie(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showLogoutDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext innerContext) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.current.logout.toUpperCase(),
                style: AppTextStyles.s18w600Primary(),
              ),
              const SizedBox(
                height: Dimens.d6,
              ),
              Text(
                S.current.sureforlogout,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<MyPageBloc>()
                          .add(const IsLogin(is_login: false));
                       context
                          .read<MyPageBloc>()
                          .add(const LogoutButtonPress());
                      navigator.pop();
                      navigator.replace(const AppRouteInfo.main());
                    },
                    child: Text(S.current.logout,
                        style: AppTextStyles.s16w600Primary()),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      navigator.pop(); // Đóng BottomSheet
                    },
                    child: Text(
                      S.current.cancel,
                      style: AppTextStyles.s16w600Primary(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
