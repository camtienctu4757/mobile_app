import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../domain.dart';

part 'get_local_user_usecase.freezed.dart';

@Injectable()
class GetLocalUserUseCase extends BaseFutureUseCase<GetLocalUserInput, GetLocalUserOutput> {
  GetLocalUserUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<GetLocalUserOutput> buildUseCase(GetLocalUserInput input) async {
    return GetLocalUserOutput(user: _repository.getUserPreference());
  }
}

@freezed
class GetLocalUserInput extends BaseInput with _$GetLocalUserInput {
  const factory GetLocalUserInput() = _GetLocalUserInput;
}

@freezed
class GetLocalUserOutput extends BaseOutput with _$GetLocalUserOutput {
  const GetLocalUserOutput._();

  const factory GetLocalUserOutput({
    User? user,
  }) = _GetLocalUserOutput;
}
