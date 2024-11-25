import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:domain/domain.dart';
import 'package:shared/shared.dart';

class ButtonBack extends StatelessWidget {
  // ButtonBack({super.key});
  final appNavigator = GetIt.I<AppNavigator>();
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: ColorConstant.primary),
      onPressed: () async {
        await appNavigator.pop(useRootNavigator: false);
      },
    );
  }
}
