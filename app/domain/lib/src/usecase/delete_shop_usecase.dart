import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain.dart';
import 'package:flutter/material.dart';
part 'delete_shop_usecase.freezed.dart';

@Injectable()
class DeleteShopUseCase
    extends BaseFutureUseCase<DeleteShopInput, DeleteShopOutput> {
  const DeleteShopUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<DeleteShopOutput> buildUseCase(
    DeleteShopInput input,
  ) async {
    final result = await _repository.deleteShop(input.shopId);
    return DeleteShopOutput(isSuccess: result);
  }
}

@freezed
class DeleteShopInput extends BaseInput with _$DeleteShopInput {
  const factory DeleteShopInput(
      {required String shopId
      }) = _DeleteShopInput;
}

@freezed
class DeleteShopOutput extends BaseOutput with _$DeleteShopOutput {
  const DeleteShopOutput._();

  const factory DeleteShopOutput({
    required bool isSuccess
  }) = _DeleteShopOutput;
}
