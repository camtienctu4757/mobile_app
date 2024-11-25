import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/app.dart';
part 'addservice_event.freezed.dart';

abstract class AddServiceEvent extends BaseBlocEvent {
  const AddServiceEvent();
}

@freezed
class NameChangedEvent extends AddServiceEvent with _$NameChangedEvent {
  const factory NameChangedEvent({required String name}) = _NameChangedEvent;
}

@freezed
class DescriptionChangedEvent extends AddServiceEvent
    with _$DescriptionChangedEvent {
  const factory DescriptionChangedEvent({required String description}) =
      _DescriptionChangedEvent;
}

@freezed
class EmployeeChangedEvent extends AddServiceEvent with _$EmployeeChangedEvent {
  const factory EmployeeChangedEvent({required int employee}) =
      _EmployeeChangedEvent;
}

@freezed
class DurationChangedEvent extends AddServiceEvent with _$DurationChangedEvent {
  const factory DurationChangedEvent({required int duration}) =
      _DurationChangedEvent;
}

@freezed
class PriceChangedEvent extends AddServiceEvent with _$PriceChangedEvent {
  const factory PriceChangedEvent({required double price}) = _PriceChangedEvent;
}

@freezed
class ImageUploadEvent extends AddServiceEvent with _$ImageUploadEvent {
  const factory ImageUploadEvent({required Uint8List image}) =
      _ImageUploadEvent;
}

@freezed
class ClickButtonCreateEvent extends AddServiceEvent
    with _$ClickButtonCreateEvent {
  const factory ClickButtonCreateEvent(
      {required String name,
      required String description,
      required String style,
      required double price,
      required int duration,
      required int employee,
      required String shopId}) = _ClickButtonCreateEvent;
}

@freezed
class SelectStyleEvent extends AddServiceEvent
    with _$SelectStyleEvent {
  const factory SelectStyleEvent(
      {required String style}) = _SelectStyleEvent;
}
