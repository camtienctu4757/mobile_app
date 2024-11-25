import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain.dart';
import 'package:flutter/material.dart';
part 'get_appoint_success_usecase.freezed.dart';

@Injectable()
class GetAppointSuccessUseCase
    extends BaseFutureUseCase<GetAppointSuccessInput, GetAppointSuccessOutput> {
  const GetAppointSuccessUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<GetAppointSuccessOutput> buildUseCase(
    GetAppointSuccessInput input,
  ) async {
    final result  = await _repository.getBookingSuccess();
    return GetAppointSuccessOutput(result);
  }
}

@freezed
class GetAppointSuccessInput extends BaseInput with _$GetAppointSuccessInput {
  const factory GetAppointSuccessInput() = _GetAppointSuccessInput;
}

@freezed
class GetAppointSuccessOutput extends BaseOutput with _$GetAppointSuccessOutput {
  const GetAppointSuccessOutput._();
  
  const factory GetAppointSuccessOutput(
    List<AppointmentItem?> booking_success
  ) = _GetAppointSuccessOutput;
}
