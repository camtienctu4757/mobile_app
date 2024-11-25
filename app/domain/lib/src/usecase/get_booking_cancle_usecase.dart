import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain.dart';
import 'package:flutter/material.dart';
part 'get_booking_cancle_usecase.freezed.dart';

@Injectable()
class GetBookingCancleUseCase
    extends BaseFutureUseCase<GetBookingCancleInput, GetBookingCancleOutput> {
  const GetBookingCancleUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<GetBookingCancleOutput> buildUseCase(
    GetBookingCancleInput input,
  ) async {
    final result  = await _repository.getBookingSuccess();
    return GetBookingCancleOutput(result);
  }
}

@freezed
class GetBookingCancleInput extends BaseInput with _$GetBookingCancleInput {
  const factory GetBookingCancleInput() = _GetBookingCancleInput;
}

@freezed
class GetBookingCancleOutput extends BaseOutput with _$GetBookingCancleOutput {
  const GetBookingCancleOutput._();
  
  const factory GetBookingCancleOutput(
    List<AppointmentItem?> booking_cancle
  ) = _GetBookingCancleOutput;
}
