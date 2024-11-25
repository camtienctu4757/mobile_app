import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../../../domain.dart';

part 'get_service_byshop_usecase.freezed.dart';

@Injectable()
class GetServicesByShopUseCase
    extends BaseFutureUseCase<GetServiceByShopInput, GetServiceByShopOut> {
  GetServicesByShopUseCase(this._repository) : super();

  final Repository _repository;

  @protected
  @override
  Future<GetServiceByShopOut> buildUseCase(GetServiceByShopInput input) async {
    final result = await _repository.getServicesByShop(shopId: input.shopId);
    return GetServiceByShopOut(result);
  }
}

@freezed
class GetServiceByShopInput extends BaseInput with _$GetServiceByShopInput {
  const factory GetServiceByShopInput({required String shopId}) =
      _GetServiceByShopInput;
}

@freezed
class GetServiceByShopOut extends BaseOutput with _$GetServiceByShopOut {
  const factory GetServiceByShopOut(List<ServiceItem>? services) =
      _GetServiceByShopOut;
}
