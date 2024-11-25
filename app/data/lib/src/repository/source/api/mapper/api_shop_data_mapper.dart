import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import '../../../../../data.dart';

@Injectable()
class ApiShopDataMapper extends BaseDataMapper<ApiGetShopResponseData, Shop> {
  ApiShopDataMapper(
  );

  @override
  Shop mapToEntity(ApiGetShopResponseData? data) {
    return Shop(
      name: data?.name ?? Shop.defaultName,
      address: data?.address ?? Shop.defaultAddress,
      email: data?.email ?? Shop.defaultEmail,
      open:data?.openTime ?? Shop.defaultOpenEpoch,
      close:data?.closedTime ?? Shop.defaultCloseEpoch,
      phone: data?.phone ?? Shop.defaultPhone,
      id: data?.shopId ?? Shop.defaultId     
    );
  }
}
