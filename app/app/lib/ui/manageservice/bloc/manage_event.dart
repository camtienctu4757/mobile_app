import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app/app.dart';
part 'manage_event.freezed.dart';

abstract class ServiceManageEvent extends BaseBlocEvent {
  const ServiceManageEvent();
}

@freezed
class ServiceManagePageInitiated extends ServiceManageEvent with _$ServiceManagePageInitiated {
  const factory ServiceManagePageInitiated({ required String shop_id}) = _ServiceManagePageInitiated;
}
@freezed
class LoadServiceImage extends ServiceManageEvent with _$LoadServiceImage {
  const factory LoadServiceImage({required Map<String, dynamic>? queryParameters,  required Photo image_url, required String service_id}) = _LoadServiceImage;
}


