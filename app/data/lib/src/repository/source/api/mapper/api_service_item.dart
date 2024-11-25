import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import '../../../../../data.dart';

@Injectable()
class ApiServiceItemMapper extends BaseDataMapper<ApiServiceItemData, ServiceItem> {
  ApiServiceItemMapper(
  );

  @override
  ServiceItem mapToEntity(ApiServiceItemData? data) {
    return ServiceItem(
      id: data?.id ?? ServiceItem.defaultId,
      name: data?.name ?? ServiceItem.defaultName,
      price: data?.price ?? ServiceItem.defaultPrice,
      description: data?.description ?? ServiceItem.defaultDescription,
      shopId: data?.shop_id ?? ServiceItem.defaultShopId,
      duration: data?.duration ?? ServiceItem.defaultDuration,
      employee: data?.employee ?? ServiceItem.defaultEmployee
    );
  }
}
