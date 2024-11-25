import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import '../../../../../data.dart';
import '../model/api_get_time_slot.dart';

@Injectable()
class ApiGetBookingMapper extends BaseDataMapper<ApiGetBooking, AppointmentItem> {
  ApiGetBookingMapper(
  );

  @override
  AppointmentItem mapToEntity(ApiGetBooking? data) {
    return AppointmentItem(
     id: data?.id ?? AppointmentItem.defaultId,
     duration: data?.duration ?? AppointmentItem.defaultDuration,
     price: data?.price ?? AppointmentItem.defaultPrice,
     appointmentDate: data?.slot_date ?? AppointmentItem.defaultAppointmentDate,
     appointmentTime: data?.start_time ?? AppointmentItem.defaultAppointmentTime,
     serviceName: data?.service_name ?? AppointmentItem.defaultServicename,
     storeAddress:data?.address??AppointmentItem.defaultStoreAddress,
     storeName: data?.shop_name??AppointmentItem.defaultStoreName
     
    );
  }
}
