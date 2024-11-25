import 'package:app/app.dart';
import 'package:app/ui/storetab/bloc/storetab.dart';
import 'package:app/ui/storetab/bloc/storetab_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Store extends StatefulWidget {
  const Store({super.key});
  @override
  State<Store> createState() => _StoreState();
}

class _StoreState extends State<Store> {
  // @override
  // void initState() {
  //   super.initState();
  //   context.read<StoreBloc>().add(const StoreTabInitiated());
  // }

  @override
  Widget build(BuildContext context) {
    // context.read<StoreBloc>().add(const StoreTabInitiated());
    return CommonScaffold(
      body: BlocBuilder<StoreBloc, StoreState>(
        builder: (context, state) {
          if (state.StoreLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.getShopSuccess) {
            return const MyShopListPage();
          } else {
            return const NonShopPage();
          }
        },
      ),
    );
  }
}
