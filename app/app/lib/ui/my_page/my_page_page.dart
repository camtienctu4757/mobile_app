import 'package:app/ui/account/bloc/account.dart';
import 'package:app/ui/account/bloc/account_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';
import 'package:get_it/get_it.dart';
import '../../app.dart';
import 'bloc/my_page.dart';

@RoutePage(name: 'MyPageRoute')
class MyPagePage extends StatefulWidget {
  const MyPagePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyPagePageState();
  }
}

class _MyPagePageState extends BasePageState<MyPagePage, MyPageBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountBloc(
          GetIt.I.get<LogoutUseCase>(),
              GetIt.I.get<GetImageUserUseCase>(),
              GetIt.I.get<GetUsersUseCase>(),
      ),
      child: CommonScaffold(
        body: BlocBuilder<MyPageBloc, MyPageState>(
          buildWhen: (previous, current) =>
              previous.ShowLoginButton != current.ShowLoginButton,
          builder: (context, state) {
            if (state.ShowLoginButton == false) {
               
              return const AccountPage();
            } else {
              return Center(
                  child: CustomElevateButton(
                textColor: Colors.white,
                text: S.current.login,
                bgColor: ColorConstant.primary,
                isIcons: false,
                onpress: () {
                  navigator.replace(const AppRouteInfo.login());
                },
              )); // Nếu chưa đăng nhập, hiển thị trang Login
            }
          },
        ),
      ),
    );
  }
}
