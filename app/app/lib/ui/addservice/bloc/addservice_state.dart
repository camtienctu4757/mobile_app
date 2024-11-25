import 'dart:typed_data';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../base/bloc/base_bloc_state.dart';
part 'addservice_state.freezed.dart';

@freezed
class AddServiceState extends BaseBlocState with _$AddServiceState {
  factory AddServiceState({
  @Default('') String name,
  @Default(0) int duration,
  @Default(0.0) double price,
  @Default('') String description,
  @Default(0) int employees,
  @Default('') String style,
  Uint8List? image
  }) = _AddServiceState;
}