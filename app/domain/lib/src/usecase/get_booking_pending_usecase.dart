import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain.dart';
import 'package:flutter/material.dart';
part 'get_booking_pending_usecase.freezed.dart';

@Injectable()
class GetBookingPendingUseCase
    extends BaseFutureUseCase<GetBookingPendingInput, GetBookingPendingOutput> {
  const GetBookingPendingUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<GetBookingPendingOutput> buildUseCase(
    GetBookingPendingInput input,
  ) async {
    final result  = await _repository.getBookingPending();
    return GetBookingPendingOutput(result);
  }
}

@freezed
class GetBookingPendingInput extends BaseInput with _$GetBookingPendingInput {
  const factory GetBookingPendingInput() = _GetBookingPendingInput;
}

@freezed
class GetBookingPendingOutput extends BaseOutput with _$GetBookingPendingOutput {
  const GetBookingPendingOutput._();
  
  const factory GetBookingPendingOutput(
    List<AppointmentItem?> booking_pending
  ) = _GetBookingPendingOutput;
}
