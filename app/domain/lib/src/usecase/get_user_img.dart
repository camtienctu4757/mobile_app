import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../domain.dart';
import 'dart:typed_data';
part 'get_user_img.freezed.dart';

@Injectable()
class GetImageUserUseCase
    extends BaseFutureUseCase<GetImageUserInput, GetImageUserOutput> {
  GetImageUserUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<GetImageUserOutput> buildUseCase(GetImageUserInput input) async {
    final result = await _repository.getuserImg(
  query: input.queryParameters);
    return GetImageUserOutput(image: result);
  }
}

@freezed
class GetImageUserInput extends BaseInput with _$GetImageUserInput {
  const factory GetImageUserInput(
      {
      Map<String, dynamic>? queryParameters}) = _GetImageUserInput;
}

@freezed
class GetImageUserOutput extends BaseOutput with _$GetImageUserOutput {
  const GetImageUserOutput._();
  const factory GetImageUserOutput({
    Uint8List? image,
  }) = _GetImageUserOutput;
}
