import 'package:injectable/injectable.dart';
import 'package:app/app.dart';
import 'restday.dart';

@Injectable()
class RestDayShopBloc extends BaseBloc<RestDayEvent, RestDayState> {
  RestDayShopBloc() : super(const RestDayState()) {
    // on<RestDayShopPageInitiated>(_onRestDayShopPageInitiated);
    // on<SelectedProvince>(_onSelectedProvince);
    // on<SelectedDistrict>(_onSelectedDistrict);
    // on<SelectedWard>(_onSelectedWard);
  }

  // FutureOr<void> _onRestDayShopPageInitiated(
  //     RestDayShopPageInitiated event, Emitter<RestDayShopState> emit) async {
  //   emit(state.copyWith(step: event.step));
  // }

  // Future<void> _onSelectedProvince(
  //     SelectedProvince event, Emitter<RestDayShopState> emit) async {

  // }
  //   Future<void> _onSelectedDistrict(
  //     SelectedDistrict event, Emitter<RestDayShopState> emit) async {
  //   emit(state.copyWith());
  // }
  //  Future<void> _onSelectedWard(
  //     SelectedWard event, Emitter<RestDayShopState> emit) async {
  //   emit(state.copyWith());
  // }
}
