import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain.dart';
part 'delete_service_usecase.freezed.dart';

@Injectable()
class DeleteServiceUseCase
    extends BaseFutureUseCase<DeleteServiceInput, DeleteServiceOutput> {
  const DeleteServiceUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<DeleteServiceOutput> buildUseCase(
    DeleteServiceInput input,
  ) async {
    final result = await _repository.deleteService(input.ServiceId);
    return DeleteServiceOutput(isSuccess: result);
  }
}

@freezed
class DeleteServiceInput extends BaseInput with _$DeleteServiceInput {
  const factory DeleteServiceInput(
      {required String ServiceId
      }) = _DeleteServiceInput;
}

@freezed
class DeleteServiceOutput extends BaseOutput with _$DeleteServiceOutput {
  const DeleteServiceOutput._();

  const factory DeleteServiceOutput({
    required bool isSuccess
  }) = _DeleteServiceOutput;
}
