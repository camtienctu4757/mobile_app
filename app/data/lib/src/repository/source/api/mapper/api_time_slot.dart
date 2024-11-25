import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import '../../../../../data.dart';
import '../model/api_get_time_slot.dart';

@Injectable()
class ApiTimeSlotMapper extends BaseDataMapper<ApiGetTimeSlot, TimeSlot> {
  ApiTimeSlotMapper(
  );

  @override
  TimeSlot mapToEntity(ApiGetTimeSlot? data) {
    return TimeSlot(
      id: data?.id ?? TimeSlot.defaultId,
      service_id: data?.servie_id ?? TimeSlot.defaultServiceId,
      available: data?.available ?? TimeSlot.defaultAvailable,
      end_time: data?.end_time ?? TimeSlot.defaultEndTime,
      slot_date: data?.slot_date ?? TimeSlot.defaultSlotDate,
      start_time: data?.start_time ?? TimeSlot.defaultStartTime,
    );
  }
}
