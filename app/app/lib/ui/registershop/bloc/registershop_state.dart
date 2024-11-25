import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:app/app.dart';
import 'package:domain/domain.dart';
import 'package:shared/shared.dart';
part 'registershop_state.freezed.dart';

@freezed
class RegisterShopState extends BaseBlocState with _$RegisterShopState {
  const RegisterShopState._();

  const factory RegisterShopState(
      {@Default(false) bool getshoplistsuccess,
      @Default([]) List<Shop>? shopList,
      @Default('') String? ErrorPage,
      @Default(RegisterStep.storeInfo) RegisterStep step,
      @Default('') String storeName,
      @Default('') String address,
      @Default('') String contact,
      @Default('') String phone,
      @Default('') String confirmationCode,
      @Default('') String businessLicenseNumber,
      @Default('') String businessIndustry,
      @Default('') String licenseFile,
      @Default('') String selectedProvince,
      TimeOfDay? openTime,
      TimeOfDay? closedTime,
      @Default('') String selectedDistrict,
      @Default('') String selectedWard}) = _RegisterShopState;
}
