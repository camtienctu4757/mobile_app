import 'package:app/resource/styles/app_text_styles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/login.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends BasePageState<LoginPage, LoginBloc> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    bloc.add(const InitialLogin());
  }

  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      hideKeyboardWhenTouchOutside: true,
      appBar: CommonAppBar(
        leadingWidth: Dimens.d40,
        leadingIcon: navigator.canPopSelfOrChildren
            ? LeadingIcon.back
            : LeadingIcon.none,
        leadingIconColor: ColorConstant.primary,
        titleType: AppBarTitle.text,
        centerTitle: true,
        text: S.current.login,
        backgroundColor: ColorConstant.white,
        titleTextStyle: AppTextStyles.s16w600Primary(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Dimens.d16.responsive()),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome!',
                  style: AppTextStyles.s16w600Primary(),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              AppTextField(
                controller: _usernameController,
                obscure: false,
                title: S.current.email,
                hintText: S.current.email,
                onChanged: (email) =>
                    bloc.add(EmailTextFieldChanged(email: email)),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: Dimens.d24.responsive()),
              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return AppTextField(
                    controller: _passwordController,
                    obscure: state.obscureText,
                    title: S.current.password,
                    hintText: S.current.password,
                    suffixIcon: IconButton(
                        icon: Icon(state.obscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash),
                        color: ColorConstant.textbacklight,
                        onPressed: () => bloc.add(const EyeIconPressed())),
                    onChanged: (pass) =>
                        bloc.add(PasswordTextFieldChanged(password: pass)),
                    keyboardType: TextInputType.visiblePassword,
                  );
                },
              ),
              SizedBox(height: Dimens.d15.responsive()),
              // BlocBuilder<LoginBloc, LoginState>(
              //     buildWhen: (previous, current) =>
              //         ((previous.onPageError != current.onPageError)),
              //     builder: (_, state) {
              //       return state.onPageError.isEmpty
              //           ? const Text('')
              //           : showDialog()
              //     }),
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) =>
                    previous.onPageError != current.onPageError,
                builder: (context, state) {
                  if (state.onPageError.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(state
                                      .onPageError), // Display the error message
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  bloc.add(const InitialLogin());
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text(
                                  'OK',
                                  style: AppTextStyles.s16wBoldPrimary(),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    });
                  }
                  return const SizedBox.shrink();
                },
              ),
              BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (previous, current) =>
                    previous.isLoginButtonEnabled !=
                    current.isLoginButtonEnabled,
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.isLoginButtonEnabled == true
                        ? () => bloc.add(const LoginButtonPressed())
                        : null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(AppColors
                          .current.primaryColor
                          .withOpacity(state.isLoginButtonEnabled ? 1 : 0.5)),
                    ),
                    child: Text(
                      S.current.login,
                      style: AppTextStyles.s16w600White(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              // BlocBuilder<LoginBloc, LoginState>(
              //   buildWhen: (previous, current) => current.onPageError != nul ,
              //   builder: (context, state) => showDialog(context: context, builder: ),
              // ),
              // Text(S.current.loginwith, style: AppTextStyles.s14w400Black()),
              // const SizedBox(
              //   height: 8,
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     ElevatedButton.icon(
              //       onPressed: () {},
              //       icon: const Icon(
              //         FontAwesomeIcons.google,
              //         color: ColorConstant.text_gg,
              //       ),
              //       label: const Text(
              //         "Google",
              //         style: TextStyle(color: ColorConstant.text_gg),
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
                  // ElevatedButton.icon(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     FontAwesomeIcons.facebook,
                  //     color: ColorConstant.text_gg,
                  //   ),
                  //   label: const Text(
                  //     "Facebook",
                  //     style: TextStyle(color: ColorConstant.text_gg),
                  //   ),
                  // )
                // ],
              // ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.current.havenoaccount,
                    style: AppTextStyles.s14w400Black(),
                  ),
                  TextButton(
                    onPressed: () {
                      _usernameController.clear();
                      _passwordController.clear();
                      navigator.push(const AppRouteInfo.register());
                    },
                    child: Text(
                      S.current.signup,
                      style: AppTextStyles.s14w400Hint(),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
