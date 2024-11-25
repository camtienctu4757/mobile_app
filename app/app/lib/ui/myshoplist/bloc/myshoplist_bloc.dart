import 'dart:async';
import 'package:app/ui/myshoplist/bloc/myshoplist_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'my_shop_list.dart';
import 'package:injectable/injectable.dart';
import 'package:app/app.dart';
import 'package:domain/domain.dart';

@Injectable()
class MyShopListBloc extends BaseBloc<MyShopListEvent, MyShopListState> {
  MyShopListBloc(this._getLocalUserUseCase, this._loadShopListUsecase) : super(const MyShopListState()) {
    on<MyShopListPageInitiated>(
      _onMyShopListPageInitiated,
      transformer: distinct(),
    );
  }
final GetLocalUserUseCase _getLocalUserUseCase;
final GetShopsUseCase _loadShopListUsecase;
  FutureOr<void> _onMyShopListPageInitiated(
      MyShopListPageInitiated event, Emitter<MyShopListState> emit) async {
        final userOut =
        await _getLocalUserUseCase.execute(const GetLocalUserInput());
    if (userOut.user != null) {
      try {
         final shopList =
                await _loadShopListUsecase.execute(const GetShopInput());
            if (shopList.shops.isNotEmpty) {
              emit(state.copyWith(
                getShopSuccess: true,
                loadShopList: shopList.shops,
              ));
            } else {
              emit(state.copyWith(
                getShopSuccess: false,
              ));
            }
      } catch (e) {
        print("Unhandled error: $e");
      }
    }
      }
}
