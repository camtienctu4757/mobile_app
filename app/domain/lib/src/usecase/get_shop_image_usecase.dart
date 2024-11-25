import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../domain.dart';
import 'dart:typed_data';
part 'get_shop_image_usecase.freezed.dart';

@Injectable()
class GetImageShopUseCase
    extends BaseFutureUseCase<GetImageShopInput, GetImageShopOutput> {
  GetImageShopUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<GetImageShopOutput> buildUseCase(GetImageShopInput input) async {
    final result = await _repository.getShopImg(
  query: input.queryParameters);
    return GetImageShopOutput(image: result);
  }
}

@freezed
class GetImageShopInput extends BaseInput with _$GetImageShopInput {
  const factory GetImageShopInput(
      {
      Map<String, dynamic>? queryParameters}) = _GetImageShopInput;
}

@freezed
class GetImageShopOutput extends BaseOutput with _$GetImageShopOutput {
  const GetImageShopOutput._();
  const factory GetImageShopOutput({
    Uint8List? image,
  }) = _GetImageShopOutput;
}
