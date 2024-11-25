import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'map_state.freezed.dart';

@freezed
class MapState extends BaseBlocState with _$MapState {
  const MapState._();

  const factory MapState({
    @Default(LatLng(10.029939, 105.7680404)) LatLng onPick
  }) = _MapState;

}