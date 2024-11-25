import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain.dart';
part 'shop_update_success_usecase.freezed.dart';

@Injectable()
class ShopUpdateSuccessUseCase extends BaseFutureUseCase<
    ShopUpdateSuccessInput,ShopUpdateSuccessOutput> {
  const ShopUpdateSuccessUseCase(
    this._repository,
  );

  final Repository _repository;

  @protected
  @override
  Future<ShopUpdateSuccessOutput> buildUseCase(ShopUpdateSuccessInput input) async {
    final response = await _repository.shopUpdateSuccess(id: input.id);
    return ShopUpdateSuccessOutput(isSuccess: response);
  }
}

@freezed
class ShopUpdateSuccessInput extends BaseInput with 
   _$ShopUpdateSuccessInput{
  const factory ShopUpdateSuccessInput({required String id}) =
      _ShopUpdateSuccessInput;
}

@freezed
class ShopUpdateSuccessOutput extends BaseOutput with 
   _$ShopUpdateSuccessOutput {
  const ShopUpdateSuccessOutput._();

  const factory ShopUpdateSuccessOutput({required bool isSuccess}) = _ShopUpdateSuccessOutput;
}
