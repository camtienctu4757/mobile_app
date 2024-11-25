import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:app/app.dart';
import 'registershop.dart';
import 'package:domain/domain.dart';

@Injectable()
class RegisterShopBloc extends BaseBloc<RegisterShopEvent, RegisterShopState> {
  RegisterShopBloc(this._createShopUseCase) : super(const RegisterShopState()) {
    on<RegisterShopPageInitiated>(_onRegisterShopPageInitiated);
    on<SelectedProvince>(_onSelectedProvince);
    on<SelectedDistrict>(_onSelectedDistrict);
    on<SelectedWard>(_onSelectedWard);
    on<InputShopName>(_onChangeShopName);
    on<InputShopPhone>(_onChangeShopPhone);
    on<InputShopContact>(_onChangeShopContact);
    on<InputShopAddress>(_onChangeShopAddress);
    on<RegisterShopButtonClick>(_onRegisterShopButtonClick);
    on<InputShopOpenTime>(_onPickOpenTime);
    on<InputShopCloseTime>(_onPickCloseTime);
  }
  final CreateShopUseCase _createShopUseCase;
  FutureOr<void> _onRegisterShopPageInitiated(
      RegisterShopPageInitiated event, Emitter<RegisterShopState> emit) async {
    emit(state.copyWith(step: event.step));
  }

  Future<void> _onSelectedProvince(
      SelectedProvince event, Emitter<RegisterShopState> emit) async {}
  Future<void> _onSelectedDistrict(
      SelectedDistrict event, Emitter<RegisterShopState> emit) async {
    emit(state.copyWith());
  }

  Future<void> _onSelectedWard(
      SelectedWard event, Emitter<RegisterShopState> emit) async {
    emit(state.copyWith());
  }

  Future<void> _onChangeShopName(
      InputShopName event, Emitter<RegisterShopState> emit) async {
    emit(state.copyWith(storeName: event.name));
  }

  Future<void> _onPickOpenTime(
      InputShopOpenTime event, Emitter<RegisterShopState> emit) async {
    print("event time" + event.time.toString());
    emit(state.copyWith(openTime: event.time));
  }

  Future<void> _onPickCloseTime(
      InputShopCloseTime event, Emitter<RegisterShopState> emit) async {
    print("event time" + event.time.toString());
    emit(state.copyWith(closedTime: event.time));
  }

  Future<void> _onChangeShopPhone(
      InputShopPhone event, Emitter<RegisterShopState> emit) async {
    emit(state.copyWith(phone: event.phone));
  }

  Future<void> _onChangeShopContact(
      InputShopContact event, Emitter<RegisterShopState> emit) async {
    emit(state.copyWith(contact: event.contact));
  }

  Future<void> _onChangeShopAddress(
      InputShopAddress event, Emitter<RegisterShopState> emit) async {
    emit(state.copyWith(address: event.address));
  }

  Future<void> _onRegisterShopButtonClick(
      RegisterShopButtonClick event, Emitter<RegisterShopState> emit) {
    return runBlocCatching(
      action: () async {
        await _createShopUseCase.execute(CreateShopInput(
            address: event.address,
            close: event.close,
            email: event.contact,
            open: event.open,
            phone: event.phone,
            shopName: event.name));
        navigator.popUntilRoot();
      },
      handleError: false,
    );
  }
}
