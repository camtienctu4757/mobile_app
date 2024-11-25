import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain.dart';
import 'package:flutter/material.dart';
part 'create_service_usecase.freezed.dart';

@Injectable()
class CreateServiceUseCase
    extends BaseFutureUseCase<CreateServiceInput, CreateServiceOutput> {
  const CreateServiceUseCase(this._repository);

  final Repository _repository;

  @protected
  @override
  Future<CreateServiceOutput> buildUseCase(
    CreateServiceInput input,
  ) async {
    await _repository.CreateService(
     name: input.name,
     description: input.description,
     style: input.style,
     price: input.price,
     duration: input.duration,
     employee: input.employee,
     shopId: input.shopId
    );

    return const CreateServiceOutput();
  }
}

@freezed
class CreateServiceInput extends BaseInput with _$CreateServiceInput {
  const factory CreateServiceInput({
    required String name,
    required String description,
    required String style,
    required double price,
    required int duration,
    required int employee,
    required String shopId
  }) = _CreateServiceInput;
}

@freezed
class CreateServiceOutput extends BaseOutput with _$CreateServiceOutput {
  const CreateServiceOutput._();

  const factory CreateServiceOutput() = _CreateServiceOutput;
}
