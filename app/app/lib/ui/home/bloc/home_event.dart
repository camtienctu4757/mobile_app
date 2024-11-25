import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../base/bloc/base_bloc_event.dart';

part 'home_event.freezed.dart';

abstract class HomeEvent extends BaseBlocEvent {
  const HomeEvent();
}

@freezed
class HomePageInitiated extends HomeEvent with _$HomePageInitiated {
  const factory HomePageInitiated() = _HomePageInitiated;
}

@freezed
class HomePageRefreshed extends HomeEvent with _$HomePageRefreshed {
  const factory HomePageRefreshed({
    required Completer<void> completer,
}) = _HomePageRefreshed;
}

@freezed
class ServiceLoadMore extends HomeEvent with _$ServiceLoadMore {
  const factory ServiceLoadMore() = _ServiceLoadMore;
}

@freezed
class SearchQueryChanged extends HomeEvent with _$SearchQueryChanged {
  const factory SearchQueryChanged({required String query}) = _SearchQueryChanged;
}
  
@freezed
class CategorySelected extends HomeEvent with _$CategorySelected {
  const factory CategorySelected({required String category}) = _CategorySelected;
}

@freezed
class ServiceLoadImage extends HomeEvent with _$ServiceLoadImage {
  const factory ServiceLoadImage({required String path, required Map<String, dynamic>? queryParameters}) = _ServiceLoadImage;
}

@freezed
class LoadTimeSlot extends HomeEvent with _$LoadTimeSlot {
  const factory LoadTimeSlot({required String serviceId}) = _LoadTimeSlot;
}

@freezed
class CreateAppoint extends HomeEvent with _$CreateAppoint {
  const factory CreateAppoint({required String timeslot_id}) = _CreateAppoint;
}

@freezed
class CreatAppointMess extends HomeEvent with _$CreatAppointMess {
  const factory CreatAppointMess({required String mess}) = _CreatAppointMess;
}



