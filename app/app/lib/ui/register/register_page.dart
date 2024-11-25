import 'package:app/ui/register/bloc/register_event.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

import '../../app.dart';
import 'bloc/register.dart';

@RoutePage()
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends BasePageState<RegisterPage, RegisterBloc> {
    @override
  void initState() {
    super.initState();
    bloc.add(const InitialRegister());
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
        text: S.current.signup,
        backgroundColor: ColorConstant.white,
        titleTextStyle: AppTextStyles.s16w600Primary(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(Dimens.d16.responsive()),
          child: Column(
            children: [
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return AppTextField(
                              obscure: false,
                              title: S.current.userame,
                              hintText: S.current.userame,
                              errorText: state.nameError,
                              onChanged: (name) =>
                                      bloc.add(NameChangeed(name: name)),
                              keyboardType: TextInputType.text,
                            );
                },
              ),
              SizedBox(height: Dimens.d20.responsive()),
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return AppTextField(
                    obscure: false,
                    title: S.current.email,
                    hintText: S.current.email,
                    errorText: state.emailError,
                    onChanged: (email) =>
                        bloc.add(EmailTextFieldChanged(email: email)),
                    keyboardType: TextInputType.emailAddress,
                  );
                },
              ),
              SizedBox(height: Dimens.d20.responsive()),
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return AppTextField(
                    obscure: state.obscurepassword,
                    title: S.current.password,
                    hintText: S.current.password,
                    suffixIcon: IconButton(
                        icon: Icon(state.obscurepassword
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash),
                        color: ColorConstant.textbacklight,
                        onPressed: () => bloc.add(const EyeIconPressedPass())),
                    onChanged: (pass) =>
                        bloc.add(PasswordTextFieldChanged(password: pass)),
                    keyboardType: TextInputType.visiblePassword,
                    errorText: state.passError
                  );
                },
              ),
              SizedBox(height: Dimens.d20.responsive()),
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return AppTextField(
                    obscure: state.obscureconfirm,
                    title: S.current.conform,
                    hintText: S.current.conform,
                    suffixIcon: IconButton(
                        icon: Icon(state.obscureconfirm
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash),
                        color: ColorConstant.textbacklight,
                        onPressed: () =>
                            bloc.add(const EyeIconPressedPassConfirm())),
                    onChanged: (pass) =>
                        bloc.add(ConfirmPasswordChangeed(confirmpass: pass)),
                    keyboardType: TextInputType.visiblePassword,
                    errorText: state.confirmError
                  );
                },
              ),
              SizedBox(height: Dimens.d20.responsive()),
              BlocBuilder<RegisterBloc, RegisterState>(
                builder: (context, state) {
                  return AppTextField(
                    obscure: false,
                    title: S.current.phone,
                    hintText: S.current.phone,
                    errorText: state.phoneError,
                    onChanged: (phone) => bloc.add(PhoneChange(phone: phone)),
                    keyboardType: TextInputType.number,
                  );
                },
              ),
              SizedBox(height: Dimens.d15.responsive()),
             
              BlocBuilder<RegisterBloc, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.onPageError != current.onPageError,
                builder: (context, state) {
                  if (state.onPageError.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title:  Text(S.current.errorhappen),
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
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text('OK', style: AppTextStyles.s16wBoldPrimary(),),
                                
                              ),
                            ],
                          );
                        },
                      );
                    });
                  }
                  return const SizedBox
                      .shrink();
                },
              ),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<RegisterBloc, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.isRegisterButtonEnabled !=
                    current.isRegisterButtonEnabled,
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.isRegisterButtonEnabled == true
                        ? () => bloc.add(const RegisterButtonPress())
                        : null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          AppColors.current.primaryColor.withOpacity(
                              state.isRegisterButtonEnabled ? 1 : 0.5)),
                    ),
                    child: Text(
                      S.current.signup,
                      style: AppTextStyles.s16w600White(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: Dimens.d8,
              ),
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
              //     ElevatedButton.icon(
              //       onPressed: () {},
              //       icon: const Icon(
              //         FontAwesomeIcons.facebook,
              //         color: ColorConstant.text_gg,
              //       ),
              //       label: const Text(
              //         "Facebook",
              //         style: TextStyle(color: ColorConstant.text_gg),
              //       ),
              //     )
              //   ],
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    S.current.haveaccount,
                    style: AppTextStyles.s14w400Black(),
                  ),
                  TextButton(
                    onPressed: () {
                      navigator.pop(result: const LoginPage());
                    },
                    child: Text(
                      S.current.login,
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
