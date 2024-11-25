import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../domain.dart';

part 'get_users_use_case.freezed.dart';

@Injectable()
class GetUsersUseCase extends BaseFutureUseCase<GetUsersInput, GetUsersOutput> {
  GetUsersUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<GetUsersOutput> buildUseCase(GetUsersInput input) async {
    User? result = await _repository.getMe();
    return GetUsersOutput(user: result);
  }
}

@freezed
class GetUsersInput extends BaseInput with _$GetUsersInput {
  const factory GetUsersInput() = _GetUsersInput;
}

@freezed
class GetUsersOutput extends BaseOutput with _$GetUsersOutput {
  const GetUsersOutput._();

  const factory GetUsersOutput({
    User? user,
  }) = _GetUsersOutput;
}
