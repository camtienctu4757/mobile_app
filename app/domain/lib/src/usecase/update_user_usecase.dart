import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain.dart';
part 'update_user_usecase.freezed.dart';

@Injectable()
class UpdateUserUseCase
    extends BaseFutureUseCase<UpdateUserInput, UpdateUserOutput> {
  const UpdateUserUseCase(
    this._repository,
  );

  final Repository _repository;

  @protected
  @override
  Future<UpdateUserOutput> buildUseCase(UpdateUserInput input) async {
    final response = await _repository.updateUser(
        input.name, input.phone, input.email, input.id);
    return UpdateUserOutput(isSuccess: response);
  }
}

@freezed
class UpdateUserInput extends BaseInput with _$UpdateUserInput {
  const factory UpdateUserInput(
      {required String name,
      required String phone,
      required String email,
      required String id}) = _UpdateUserUseCase;
}

@freezed
class UpdateUserOutput extends BaseOutput with _$UpdateUserOutput {
  const UpdateUserOutput._();

  const factory UpdateUserOutput({required bool isSuccess}) = _UpdateUserOutput;
}
