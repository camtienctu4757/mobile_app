import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain.dart';
import 'package:flutter/material.dart';
part 'create_shop_usecase.freezed.dart';

@Injectable()
class CreateShopUseCase
    extends BaseFutureUseCase<CreateShopInput, CreateShopOutput> {
  const CreateShopUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<CreateShopOutput> buildUseCase(
    CreateShopInput input,
  ) async {
    await _repository.createShop(
      shopName: input.shopName,
      address: input.address,
      email: input.email,
      close: input.close,
      open: input.open,
      phone: input.phone
    );

    return const CreateShopOutput();
  }
}

@freezed
class CreateShopInput extends BaseInput with _$CreateShopInput {
  const factory CreateShopInput({
    required String shopName,
    required String phone,
    required String address,
    required String email,
    required TimeOfDay open,
    required TimeOfDay close
  }) = _CreateShopInput;
}

@freezed
class CreateShopOutput extends BaseOutput with _$CreateShopOutput {
  const CreateShopOutput._();

  const factory CreateShopOutput() = _CreateShopOutput;
}
