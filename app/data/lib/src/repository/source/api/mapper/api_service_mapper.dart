import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import '../../../../../data.dart';

@Injectable()
class ApiServiceDataMapper extends BaseDataMapper<ApiServiceData, ServiceItem> {
  ApiServiceDataMapper(
  );

  @override
  ServiceItem mapToEntity(ApiServiceData? data) {
    return ServiceItem(
      id: data?.service?.id ?? ServiceItem.defaultId,
      name: data?.service?.name ?? ServiceItem.defaultName,
      price: data?.service?.price ?? ServiceItem.defaultPrice,
      photos: data?.photos?.map((photo) => Photo(
                    fileUuid: photo.id!,
                    folderPath: photo.path!,
                    fileName: photo.file_name!,
                  ))
              .toList() ??
          ServiceItem.defaultPhotos,
      description: data?.service?.description ?? ServiceItem.defaultDescription,
      shopId: data?.service?.shop_id ?? ServiceItem.defaultShopId,
      duration: data?.service?.duration ?? ServiceItem.defaultDuration,
      employee: data?.service?.employee ?? ServiceItem.defaultEmployee
    );
  }
}
