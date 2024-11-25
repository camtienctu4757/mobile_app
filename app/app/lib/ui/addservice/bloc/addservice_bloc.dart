import 'dart:async';
import 'package:domain/domain.dart';
import 'package:app/app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'addservice.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AddServiceBloc extends BaseBloc<AddServiceEvent, AddServiceState> {
  AddServiceBloc(this._createServiceUseCase) : super(AddServiceState()) {
    on<NameChangedEvent>(_onNameChanged);
    on<DescriptionChangedEvent>(
      _onDescriptionChanged,
    );
    on<EmployeeChangedEvent>(_onEmployeeChanged);
    on<DurationChangedEvent>(_onDurationChanged);
    on<PriceChangedEvent>(_onPriceChanged);
    on<ImageUploadEvent>(_onImageUpload);
    on<ClickButtonCreateEvent>(_onClickButtonCreate);
    on<SelectStyleEvent>(_onSelectStyle);
  }
  final CreateServiceUseCase _createServiceUseCase;
  FutureOr<void> _onNameChanged(
    NameChangedEvent event,
    Emitter<AddServiceState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  FutureOr<void> _onDescriptionChanged(
    DescriptionChangedEvent event,
    Emitter<AddServiceState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  FutureOr<void> _onEmployeeChanged(
    EmployeeChangedEvent event,
    Emitter<AddServiceState> emit,
  ) {
    emit(state.copyWith(employees: event.employee));
  }

  FutureOr<void> _onPriceChanged(
    PriceChangedEvent event,
    Emitter<AddServiceState> emit,
  ) {
    emit(state.copyWith(price: event.price));
  }

  FutureOr<void> _onDurationChanged(
    DurationChangedEvent event,
    Emitter<AddServiceState> emit,
  ) {
    emit(state.copyWith(duration: event.duration));
  }

  FutureOr<void> _onImageUpload(
    ImageUploadEvent event,
    Emitter<AddServiceState> emit,
  ) {
    emit(state.copyWith(image: event.image));
  }

  FutureOr<void> _onClickButtonCreate(
    ClickButtonCreateEvent event,
    Emitter<AddServiceState> emit,
  ) async {
    try {
      final result = await _createServiceUseCase.execute(CreateServiceInput(
          name: event.name,
          description: event.description,
          duration: event.duration,
          employee: event.employee,
          price: event.price,
          shopId: event.shopId,
          style: event.style));
    } catch (e) {
      logD("error creating click button : $e");
    }
  }

  void _onSelectStyle(
    SelectStyleEvent event,
    Emitter<AddServiceState> emit,
  ) {
    emit(state.copyWith(style: event.style));
  }
}
