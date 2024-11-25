import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain.dart';
import 'package:flutter/material.dart';
part 'create_appoint_usecase.freezed.dart';

@Injectable()
class CreateAppointUseCase
    extends BaseFutureUseCase<CreateAppointInput, CreateAppointOutput> {
  const CreateAppointUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<CreateAppointOutput> buildUseCase(
    CreateAppointInput input,
  ) async {
    await _repository.createAppointment(timeSlotId: input.timeslotId);

    return const CreateAppointOutput();
  }
}

@freezed
class CreateAppointInput extends BaseInput with _$CreateAppointInput {
  const factory CreateAppointInput({
    required String timeslotId,
  }) = _CreateAppointInput;
}

@freezed
class CreateAppointOutput extends BaseOutput with _$CreateAppointOutput {
  const CreateAppointOutput._();

  const factory CreateAppointOutput() = _CreateAppointOutput;
}
