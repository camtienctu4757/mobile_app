import 'dart:math';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../data.dart';
import 'dart:typed_data';

import 'model/api_get_booking.dart';
import 'model/api_get_time_slot.dart';

@LazySingleton()
class AppApiAppointment {
  AppApiAppointment(this._appointmentBaseApiClient);
  final AppointmentBaseApiClient _appointmentBaseApiClient;

  Future<bool> updateAppointSuccess(
      {required String appointId, required String token}) async {
    final result =  await _appointmentBaseApiClient.request(
      method: RestMethod.patch,
      path: '/bookings/sucsess/$appointId',
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ),
    );
    if (result == Null){
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool> updateAppointCancle(
      {required String appointId, required String token}) async {
    final result =  await _appointmentBaseApiClient.request(
      method: RestMethod.patch,
      path: '/bookings/cancle/$appointId',
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ),
    );
    if (result == Null){
      return true;
    }
    else{
      return false;
    }
  }

  Future<DataListResponse<ApiGetBooking>?> getAppointCancle(
      {required String token}) async {
    return await _appointmentBaseApiClient.request(
      method: RestMethod.get,
      path: '/bookings/cancle',
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ),
      decoder: (json) =>
          ApiServiceItemData.fromJson(json as Map<String, dynamic>),
    );
  }


  Future<DataListResponse<ApiGetBooking>?> getAppointSuccess(
      {required String token}) async {
    return await _appointmentBaseApiClient.request(
      method: RestMethod.get,
      path: '/bookings/sucsess',
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ),
      decoder: (json) => ApiGetBooking.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<DataListResponse<ApiGetBooking>?> getAppointCancleShop(
      {required String shop_id, required String token}) async {
    return await _appointmentBaseApiClient.request(
      method: RestMethod.get,
      path: '/bookings/shop/cancle/$shop_id',
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ),
      decoder: (json) => ApiGetBooking.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<DataListResponse<ApiGetBooking>?> getAppointPending(
      {required String token}) async {
    return await _appointmentBaseApiClient.request(
      method: RestMethod.get,
      path: '/bookings/pending',
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ),
      decoder: (json) => ApiGetBooking.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<DataListResponse<ApiGetBooking>?> getAppointSuccessShop(
      {required String shopId, required String token}) async {
    return await _appointmentBaseApiClient.request(
      method: RestMethod.get,
      path: '/bookings/shop/sucess/$shopId',
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ),
      decoder: (json) => ApiGetBooking.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<DataListResponse<ApiGetBooking>?> getAppointPendingShop(
      {required String shop_id, required String token}) async {
    return await _appointmentBaseApiClient.request(
      method: RestMethod.get,
      path: '/bookings/shop/pending/$shop_id',
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ),
      decoder: (json) => ApiGetBooking.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<DataListResponse<ApiGetTimeSlot>?> getTimeSlot({
    required String serviceId,
  }) async {
    return await _appointmentBaseApiClient.request(
      method: RestMethod.get,
      path: '/timeslots/service/$serviceId',
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      options: Options(
        headers: {
          'accept': 'application/json',
        },
      ),
      decoder: (json) => ApiGetTimeSlot.fromJson(json as Map<String, dynamic>),
    );
  }

  Future<DataResponse<ApiCreateBooking>?> createBooking(
      {required String token,
      required String userId,
      required String timeslotId}) async {
    return await _appointmentBaseApiClient.request(
      method: RestMethod.post,
      path: '/bookings',
      successResponseMapperType: SuccessResponseMapperType.dataJsonObject,
      options: Options(
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ),
      body: {
        "user_uuid": userId,
        "timeslot_uuid": timeslotId
      },
      decoder: (json) => ApiCreateBooking.fromJson(json as Map<String, dynamic>),
    );
  }
}
