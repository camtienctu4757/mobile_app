import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain.dart';
part 'shop_update_cancle_usecase.freezed.dart';

@Injectable()
class ShopUpdateBookingCancleUsecase
    extends BaseFutureUseCase<ShopUpdateCancleInput, ShopUpdateCancleOutput> {
  const ShopUpdateBookingCancleUsecase(
    this._repository,
  );

  final Repository _repository;

  @protected
  @override
  Future<ShopUpdateCancleOutput> buildUseCase(
      ShopUpdateCancleInput input) async {
    final response = await _repository.userUpdateCancle(id: input.id);
    return ShopUpdateCancleOutput(isSuccess: response);
  }
}

@freezed
class ShopUpdateCancleInput extends BaseInput with _$ShopUpdateCancleInput {
  const factory ShopUpdateCancleInput({required String id}) = _ShopUpdateCancleInput;
}

@freezed
class ShopUpdateCancleOutput extends BaseOutput with _$ShopUpdateCancleOutput {
  const ShopUpdateCancleOutput._();

  const factory ShopUpdateCancleOutput({required bool isSuccess}) =
      _ShopUpdateCancleOutput;
}
