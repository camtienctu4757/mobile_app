import 'package:app/app.dart';
import 'package:app/ui/addservice/bloc/addservice_bloc.dart';
import 'package:app/ui/profile/bloc/profile.dart';
import 'package:app/ui/profile/bloc/profile_bloc.dart';
import 'package:app/ui/profile/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

Widget userfield(String text, String initial, String info) {
  return Row(
    // mainAxisAlignment: MainAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: AppTextStyles.s16w600Black(),
      ),
      SizedBox(
        width: Dimens.d250,
        height: Dimens.d40,
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            return TextFormField(
              onChanged: (value) {
                switch (info) {
                  case 'name':
                   context.read<ProfileBloc>().add(ChangedName(name: value));
                    break;
                  case 'phone':
                   context.read<ProfileBloc>().add(ChangedPhone(phone: value));
                    break;
                  case 'email':
                   context.read<ProfileBloc>().add(ChangedEmail(email: value));
                }
              },
              textAlignVertical: TextAlignVertical.center,
              initialValue: initial,
              style: AppTextStyles.s16w400Black(),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                      vertical: Dimens.d5, horizontal: Dimens.d16),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(Dimens.d15)),
                  ),
                  filled: true,
                  fillColor: ColorConstant.bg_textfiled),
            );
          },
        ),
      ),
    ],
  );
}
