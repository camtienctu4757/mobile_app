import 'package:flutter/material.dart';
import '../../domain.dart';
import '../entity/service_item.dart';
import '../entity/shop.dart';
import 'dart:typed_data';

abstract class Repository {
  bool get isLoggedIn;

  bool get isFirstLaunchApp;

  bool get isFirstLogin;

  bool get isDarkMode;

  LanguageCode get languageCode;

  Stream<bool> get onConnectivityChanged;

  Future<bool> login({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<Uint8List?> getimge({Map<String, dynamic>? query});
  Future<Uint8List?> getuserImg({Map<String, dynamic>? query});

  Future<Uint8List?> getShopImg({Map<String, dynamic>? query});
  Future<void> resetPassword({
    required String token,
    required String email,
    required String password,
    required String confirmPassword,
  });

  Future<void> forgotPassword(String email);

  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String phone,
  });

  Future<Shop?> createShop(
      {required String shopName,
      required String phone,
      required String address,
      required String email,
      required TimeOfDay open,
      required TimeOfDay close});

  User getUserPreference();

  Future<void> clearCurrentUserData();

  Future<bool> saveIsFirstLogin(bool isFirstLogin);

  Future<bool> saveIsFirstLaunchApp(bool isFirstLaunchApp);

  Future<PagedList<User>> getUsers({
    required int page,
    required int? limit,
  });

  Future<List<Shop>> getShopList();

  // Future<List<NotificationItem>> getNotifications({required int userId});
  Future<bool> saveIsDarkMode(bool isDarkMode);

  Future<bool> saveLanguageCode(LanguageCode languageCode);

  Future<void> saveAccessToken(String accessToken);
  Future<void> saveRefreshToken(String refreshToken);

  Future<bool> saveUserPreference(User user);

  Future<User?> getMe();

  int putLocalUser(User user);

  Stream<List<User>> getLocalUsersStream();

  List<User> getLocalUsers();

  User? getLocalUser(int id);

  bool deleteImageUrl(int id);

  int deleteAllUsersAndImageUrls();

  Future<bool> deleteShop(String id);

  Future<bool> deleteUser();
  Future<bool> updateUser(String name, String phone, String email, String id);
  Future<bool> updateUserImage(Uint8List image);

  // service
  Future<bool> deleteService(String id);
  Future<List<ServiceItem>> getServicesByShop({required String shopId});

  Future<PagedList<ServiceItem>> searchService({
    required int page,
    required int? limit,
    required String query,
  });
  Future<PagedList<ServiceItem>> getServices({
    required int page,
    required int? limit,
  });
  Future<ServiceItem?> CreateService(
      {required String name,
      required String description,
      required String style,
      required double price,
      required int duration,
      required int employee,
      required String shopId});
  Future<PagedList<ServiceItem>> getServicesByCategory({ required String name});
  
  // appointment
  Future<List<TimeSlot>> getTimeSlot(String ServiceId);
  Future<AppointmentCreate> createAppointment({required String timeSlotId});
  Future<List<AppointmentItem?>> getBookingSuccess();
  Future<List<AppointmentItem?>> getBookingPending();
  Future<List<AppointmentItem?>> getBookingCancle();
  Future<List<AppointmentItem?>> getBookingShopSuccess(
      {required String shopId});
  Future<List<AppointmentItem?>> getBookingShopPending(
      {required String shopId});
  Future<List<AppointmentItem?>> getBookingShopCancle({required String shopId});

  Future<bool> userUpdateCancle({required String id});
  Future<bool> shopUpdateCancle({required String id});
  Future<bool> shopUpdateSuccess({required String id});
}
