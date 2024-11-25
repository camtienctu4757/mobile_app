import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';
import '../../../domain.dart';
import 'dart:typed_data';
part 'get_service_image.freezed.dart';

@Injectable()
class GetImageUseCase
    extends BaseFutureUseCase<GetImageInput, GetImageInputOutput> {
  GetImageUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<GetImageInputOutput> buildUseCase(GetImageInput input) async {
    final result = await _repository.getimge(
  query: input.queryParameters);
    return GetImageInputOutput(image: result);
  }
}

@freezed
class GetImageInput extends BaseInput with _$GetImageInput {
  const factory GetImageInput(
      {required String path,
      Map<String, dynamic>? queryParameters}) = _GetImageInput;
}

@freezed
class GetImageInputOutput extends BaseOutput with _$GetImageInputOutput {
  const GetImageInputOutput._();
  const factory GetImageInputOutput({
    Uint8List? image,
  }) = _GetImageInputOutput;
}
