import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/app.dart';
import 'package:shared/shared.dart';
part 'registershop_event.freezed.dart';

abstract class RegisterShopEvent extends BaseBlocEvent {
  const RegisterShopEvent();
}

@freezed
class RegisterShopPageInitiated extends RegisterShopEvent with _$RegisterShopPageInitiated {
  const factory RegisterShopPageInitiated({required RegisterStep step,}) = _RegisterShopPageInitiated;
}

@freezed
class SelectedProvince extends RegisterShopEvent with _$SelectedProvince {
  const factory SelectedProvince({required String selectedProvine,}) = _SelectedProvince;
}

@freezed
class SelectedDistrict extends RegisterShopEvent with _$SelectedDistrict {
  const factory SelectedDistrict({required String selectedDistrict,}) = _SelectedDistrict;
}

@freezed
class SelectedWard extends RegisterShopEvent with _$SelectedWard {
  const factory SelectedWard({required String selectedWard,}) = _SelectedWard;
}

@freezed
class InputShopName extends RegisterShopEvent with _$InputShopName {
  const factory InputShopName({required String name,}) = _InputShopName;
}

@freezed
class InputShopPhone extends RegisterShopEvent with _$InputShopPhone {
  const factory InputShopPhone({required String phone,}) = _InputShopPhone;
}


@freezed
class InputShopContact extends RegisterShopEvent with _$InputShopContact {
  const factory InputShopContact({required String contact,}) = _InputShopContact;
}
@freezed
class InputShopOpenTime extends RegisterShopEvent with _$InputShopOpenTime {
  const factory InputShopOpenTime({required TimeOfDay time,}) = _InputShopOpenTime;
}

@freezed
class InputShopCloseTime extends RegisterShopEvent with _$InputShopCloseTime {
  const factory InputShopCloseTime({required TimeOfDay time,}) = _InputShopCloseTime;
}


@freezed
class InputShopAddress extends RegisterShopEvent with _$InputShopAddress{
  const factory InputShopAddress({required String address,}) = _InputShopAddress;
}

@freezed
class RegisterShopButtonClick extends RegisterShopEvent with _$RegisterShopButtonClick{
  const factory RegisterShopButtonClick({required String address,required TimeOfDay open,required TimeOfDay close,required String name,required String phone,required String contact}) = _RegisterShopButtonClick;
}
