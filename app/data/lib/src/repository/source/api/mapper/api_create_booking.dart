import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import '../../../../../data.dart';
import '../model/api_get_time_slot.dart';

@Injectable()
class ApiCreateBookingMapper extends BaseDataMapper<ApiCreateBooking, AppointmentCreate> {
  ApiCreateBookingMapper(
  );

  @override
  AppointmentCreate mapToEntity(ApiCreateBooking? data) {
    return AppointmentCreate(
      id: data?.id ?? AppointmentCreate.defaultId,
      status: data?.status ?? AppointmentCreate.defaultStatus,
      timeslot_uuid: data?.timeslot_id ?? AppointmentCreate.defaultTimeSlotId,
      user_uuid: data?.user_id ?? AppointmentCreate.defaultUserId
    );
  }
}
