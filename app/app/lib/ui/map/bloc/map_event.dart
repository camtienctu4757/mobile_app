import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/app.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.freezed.dart';

abstract class MapEvent extends BaseBlocEvent {
  const MapEvent();
}

@freezed
class MapPageInitiated extends MapEvent with _$MapPageInitiated {
  const factory MapPageInitiated() = _MapPageInitiated;
}
@freezed
class PickerChange extends MapEvent with _$PickerChange {
  const factory PickerChange({required LatLng lat}) = _PickerChange;
}

@freezed
class LocationSearch extends MapEvent with _$LocationSearch {
  const factory LocationSearch({required String address}) = _LocationSearch;
}