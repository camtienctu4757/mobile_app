import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../domain.dart';
part 'get_timeslot_usecase.freezed.dart';

@Injectable()
class GetTimeSlotUseCase
    extends BaseFutureUseCase<GetTimeSlotInput, GetTimeSlotOutput> {
  GetTimeSlotUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<GetTimeSlotOutput> buildUseCase(GetTimeSlotInput input) async {
    final result = await _repository.getTimeSlot(input.serviceId);
    return GetTimeSlotOutput(timeslots: result);
  }
}

@freezed
class GetTimeSlotInput extends BaseInput with _$GetTimeSlotInput {
  const factory GetTimeSlotInput({required String serviceId}) =
      _GetTimeSlotInput;
}

@freezed
class GetTimeSlotOutput extends BaseOutput with _$GetTimeSlotOutput {
  const GetTimeSlotOutput._();

  const factory GetTimeSlotOutput({
    required List<TimeSlot> timeslots,
  }) = _GetTimeSlotOutput;
}
