import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../../domain.dart';
part 'get_shops_use_case.freezed.dart';

@Injectable()
class GetShopsUseCase extends BaseFutureUseCase<GetShopInput, GetShopsOutput> {
  GetShopsUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<GetShopsOutput> buildUseCase(GetShopInput input) async {
    final result = await _repository.getShopList();
    return GetShopsOutput(shops: result);
  }
}

@freezed
class GetShopInput extends BaseInput with _$GetShopInput {
  const factory GetShopInput() = _GetShopInput;
}

@freezed
class GetShopsOutput extends BaseOutput with _$GetShopsOutput {
  const GetShopsOutput._();

  const factory GetShopsOutput({
    required List<Shop> shops,
  }) = _GetShopsOutput;
}
