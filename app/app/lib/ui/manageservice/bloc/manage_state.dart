import 'package:app/ui/manageservice/bloc/manage_bloc.dart';
import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../base/bloc/base_bloc_state.dart';
import 'dart:typed_data';
part 'manage_state.freezed.dart';

@freezed
class ServiceManageState extends BaseBlocState with _$ServiceManageState {
  const ServiceManageState._();

  const factory ServiceManageState({
  @Default(false) bool getshoplistsuccess,
  @Default([]) List<ServiceItem>? serviceList,
  Uint8List? serviceImage,
  @Default([]) List<Photo> image_url,
  @Default(true) bool isLoading,
  @Default(false) bool isSuccess
  }) = _ServiceManageState;

}