import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'bloc/storetab.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app.dart';

@RoutePage()
class StorePage extends StatefulWidget {
  const StorePage({super.key});
  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final navigator = GetIt.I.get<AppNavigator>();
  @override
  void initState() {
    super.initState();
    context.read<StoreBloc>().add(const StoreTabInitiated());
  }

  @override
  Widget build(BuildContext context) {
    return  CommonScaffold(
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
