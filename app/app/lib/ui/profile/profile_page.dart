import 'package:app/ui/account/bloc/account.dart';
import 'package:app/ui/profile/bloc/widget/textfield.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';
import '../../app.dart';
import 'dart:typed_data';
import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/profile.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, this.user, this.imageData});
  final User? user;
  final Uint8List? imageData;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BasePageState<ProfilePage, ProfileBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(
        GetIt.I.get<UpdateUserUseCase>(),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(S.current.profile, style: AppTextStyles.s18w700Primary()),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: widget.imageData != null
                                ? MemoryImage(widget.imageData!)
                                    as ImageProvider<Object>
                                : const AssetImage(ImgConstants.default_user)
                                    as ImageProvider<Object>,
                          ),
                          const Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: 16,
                              child: Icon(
                                Icons.edit,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.user?.name ?? '',
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return userfield(
                          S.current.userame, widget.user?.name ?? '', 'name');
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return userfield(
                          S.current.phone, widget.user?.phone ?? '', 'phone');
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      return userfield(
                          S.current.email, widget.user?.email ?? '', 'email');
                    },
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: BlocBuilder<ProfileBloc, ProfileState>(
                          builder: (context, state) {
                            return CommonButton(
                              isText: true,
                              onPressed: () {
                                context.read<ProfileBloc>().add(
                                    UpdateUserButtonPress(
                                        name: state.name,
                                        phone: state.phone,
                                        email: state.email,
                                        id: widget.user!.id));
                                navigator.pop();
                              },
                              backgroundColor: ColorConstant.bg_button_primary,
                              borderRadius: Dimens.d8,
                              elevation: Dimens.d5,
                              text: S.current.updateprofile,
                              width: Dimens.d80,
                              style: AppTextStyles.s16w600White(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
