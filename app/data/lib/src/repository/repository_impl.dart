import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import '../../data.dart';
import 'source/api/app_api_shop.dart';
import 'source/api/mapper/api_shop_data_mapper.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'dart:typed_data';

@LazySingleton(as: Repository)
class RepositoryImpl implements Repository {
  RepositoryImpl(
      this._appApiService,
      this._appPreferences,
      this._appDatabase,
      this._preferenceUserDataMapper,
      this._userDataMapper,
      this._languageCodeDataMapper,
      this._localUserDataMapper,
      this._serviceDataMapper,
      this._shopDataMappers,
      this._appApiShop,
      this._appApiProduct,
      this._appApiServiceItemMapper,
      this._appApiAppointment,
      this._apiTimeSlotMapper,
      this._apiCreateBookingMapper,
      this._apiGetBookingMapper
      );

  final AppApiService _appApiService;
  final AppPreferences _appPreferences;
  final AppDatabase _appDatabase;
  final PreferenceUserDataMapper _preferenceUserDataMapper;
  final ApiUserDataMapper _userDataMapper;
  final ApiServiceDataMapper _serviceDataMapper;
  final LanguageCodeDataMapper _languageCodeDataMapper;
  final LocalUserDataMapper _localUserDataMapper;
  final AppApiShop _appApiShop;
  final ApiShopDataMapper _shopDataMappers;
  final AppApiProduct _appApiProduct;
  final ApiServiceItemMapper _appApiServiceItemMapper;
  final AppApiAppointment _appApiAppointment;
  final ApiTimeSlotMapper _apiTimeSlotMapper;
  final ApiCreateBookingMapper _apiCreateBookingMapper;
  final ApiGetBookingMapper _apiGetBookingMapper;
// user
  @override
  bool get isLoggedIn => _appPreferences.isLoggedIn;

  @override
  Future<bool> saveIsFirstLogin(bool isFirstLogin) {
    return _appPreferences.saveIsFirstLogin(isFirstLogin);
  }

  @override
  bool get isFirstLogin => _appPreferences.isFirstLogin;

  @override
  Future<Uint8List?> getuserImg({Map<String, dynamic>? query}) async {
    final token = await _appPreferences.accessToken;
    return _appApiService.fetchUserFile(
        accessToken: token, queryParameters: query);
  }

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final login_infor =
        await _appApiService.login(email: email, password: password);
    if (login_infor?.accessToken != null) {
      // final user_infor = await _appApiService.getMe();
      final infor = decodeJwt(login_infor?.accessToken ?? '');
      String user_name = infor['preferred_username'];
      String user_id = infor['sub'].toString();
      user_id = user_id.split(':').last;
      await Future.wait([
        saveAccessToken(login_infor?.accessToken ?? ''),
        saveRefreshToken(login_infor?.refreshToken ?? ''),
        saveUserPreference(
          User(email: email, name: user_name, id: user_id),
        ),
      ]);
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() async {
    await _appApiService.logout();
    await _appPreferences.clearCurrentUserData();
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String email,
    required String password,
    required String confirmPassword,
  }) =>
      _appApiService.resetPassword(
        token: token,
        email: email,
        password: password,
      );

  @override
  Future<void> forgotPassword(String email) =>
      _appApiService.forgotPassword(email);

  @override
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String phone,
  }) async {
    final response = await _appApiService.register(
        username: username, email: email, password: password, phone: phone);
    if (response == null) {
      return null;
    }
  }

  @override
  User getUserPreference() =>
      _preferenceUserDataMapper.mapToEntity(_appPreferences.currentUser);

  @override
  Future<void> clearCurrentUserData() => _appPreferences.clearCurrentUserData();

  @override
  Future<PagedList<User>> getUsers({
    required int page,
    required int? limit,
  }) async {
    final response = await _appApiService.getUsers(page: page, limit: limit);

    return PagedList(data: _userDataMapper.mapToListEntity(response?.results));
  }

  @override
  Future<User?> getMe() async {
    final token = await _appPreferences.accessToken;
    final response = await _appApiService.getMe(accessToken: token);
    return _userDataMapper.mapToEntity(response?.data);
  }

  @override
  int deleteAllUsersAndImageUrls() {
    return _appDatabase.deleteAllUsersAndImageUrls();
  }

  @override
  User? getLocalUser(int id) {
    return _localUserDataMapper.mapToEntity(_appDatabase.getUser(id));
  }

  @override
  List<User> getLocalUsers() {
    return _localUserDataMapper.mapToListEntity(_appDatabase.getUsers());
  }

  @override
  Stream<List<User>> getLocalUsersStream() {
    return _appDatabase
        .getUsersStream()
        .map((event) => _localUserDataMapper.mapToListEntity(event));
  }
  // @override
  // Stream<List<ServiceItem>> getServices(){
  //   return _appDatabase.getUsersStream()

  // }
  @override
  int putLocalUser(User user) {
    final userData = _localUserDataMapper.mapToData(user);

    return _appDatabase.putUser(userData);
  }

  @override
  Future<void> saveAccessToken(String accessToken) =>
      _appPreferences.saveAccessToken(accessToken);
  @override
  Future<void> saveRefreshToken(String refreshToken) =>
      _appPreferences.saveRefreshToken(refreshToken);
  @override
  Future<bool> saveUserPreference(User user) => _appPreferences
      .saveCurrentUser(_preferenceUserDataMapper.mapToData(user));

  @override
  Future<bool> deleteUser() async {
    final token = await _appPreferences.accessToken;
    final response = await _appApiService.deleteUser(token: token);
    return response != null ? true : false;
  }

  @override
  Future<bool> updateUser(
      String name, String phone, String email, String id) async {
    final token = await _appPreferences.accessToken;
    final response = await _appApiService.updateUser(
        email: email, id: id, phone: phone, token: token, username: name);

    if (response == null) {
      return true;
    }
    return false;
  }

  Future<bool> updateUserImage(Uint8List image) async {
    final token = await _appPreferences.accessToken;
    return false;
  }

// ----------------------------------------------------------------
// Common
  @override
  bool get isFirstLaunchApp => _appPreferences.isFirstLaunchApp;

  @override
  Stream<bool> get onConnectivityChanged => Connectivity()
      .onConnectivityChanged
      .map((event) => event != ConnectivityResult.none);

  @override
  bool get isDarkMode => _appPreferences.isDarkMode;

  @override
  LanguageCode get languageCode =>
      _languageCodeDataMapper.mapToEntity(_appPreferences.languageCode);

  @override
  Future<Uint8List?> getimge({Map<String, dynamic>? query}) async {
    final token = await _appPreferences.accessToken;
    return _appApiService.fetchFileWithRequest(
        accessToken: token, queryParameters: query);
  }

  @override
  Future<bool> saveIsFirstLaunchApp(bool isFirstLaunchApp) {
    return _appPreferences.saveIsFirsLaunchApp(isFirstLaunchApp);
  }

  @override
  Future<bool> saveLanguageCode(LanguageCode languageCode) {
    return _appPreferences
        .saveLanguageCode(_languageCodeDataMapper.mapToData(languageCode));
  }

  @override
  Future<bool> saveIsDarkMode(bool isDarkMode) =>
      _appPreferences.saveIsDarkMode(isDarkMode);

  @override
  bool deleteImageUrl(int id) {
    return _appDatabase.deleteImageUrl(id);
  }

// ----------------------------------------------------------------
// Shop

  @override
  Future<Uint8List?> getShopImg({Map<String, dynamic>? query}) async {
    final token = await _appPreferences.accessToken;
    return _appApiService.fetchShopFile(
        accessToken: token, queryParameters: query);
  }

  // @override
  // Future<List<NotificationItem>>getNotifications(int userId){

  // }

  @override
  Future<Shop?> createShop(
      {required String shopName,
      required String phone,
      required String address,
      required String email,
      required TimeOfDay open,
      required TimeOfDay close}) async {
    final openTime =
        '${open.hour.toString().padLeft(2, '0')}:${open.minute.toString().padLeft(2, '0')}:00';
    final closeTime =
        '${close.hour.toString().padLeft(2, '0')}:${close.minute.toString().padLeft(2, '0')}:00';
    final token = await _appPreferences.accessToken;
    final response = await _appApiShop.createShop(
        shopName: shopName,
        phone: phone,
        address: address,
        email: email,
        open: openTime,
        close: closeTime,
        token: token);
    if (response == null) {
      return null;
    }
    return _shopDataMappers.mapToEntity(response.data);
  }

  @override
  Future<List<Shop>> getShopList() async {
    final token = await _appPreferences.accessToken;
    final response = await _appApiShop.getshoplist(token: token);
    return _shopDataMappers.mapToListEntity(response?.data);
  }

  @override
  Future<bool> deleteShop(String id) async {
    final token = await _appPreferences.accessToken;
    try {
      print("$id");
      final response = await _appApiShop.deleteShop(id: id, token: token);
      return response == null ? true : false;
    } catch (e) {
      return false;
    }
  }

// ----------------------------------------------------------------
// Service
  @override
  Future<ServiceItem?> CreateService(
      {required String name,
      required String description,
      required String style,
      required double price,
      required int duration,
      required String shopId,
      required int employee}) async {
    final token = await _appPreferences.accessToken;
    final response = await _appApiProduct.CreateService(
        name: name,
        price: price,
        description: description,
        duration: duration,
        employee: employee,
        style: style,
        shopId: shopId,
        token: token);
    if (response == null) {
      return null;
    }
    return _appApiServiceItemMapper.mapToEntity(response.data);
  }

  @override
  Future<PagedList<ServiceItem>> getServices({
    required int page,
    required int? limit,
  }) async {
    final response = await _appApiService.getServices();
    return PagedList(data: _serviceDataMapper.mapToListEntity(response?.data));
  }

  @override
  Future<List<ServiceItem>> getServicesByShop({required String shopId}) async {
    final response = await _appApiService.getServicesByShop(shopId: shopId);
    return _serviceDataMapper.mapToListEntity(response?.data);
  }

  @override
  Future<PagedList<ServiceItem>> searchService({
    required int page,
    required int? limit,
    required String query,
  }) async {
    final response = await _appApiService.searchServices(query);
    return PagedList(data: _serviceDataMapper.mapToListEntity(response?.data));
  }

  @override
  Future<bool> deleteService(String id) async {
    final token = await _appPreferences.accessToken;
    final response = await _appApiProduct.deleteService(id: id, token: token);
    return response != null ? true : false;
  }

  @override
  Future<PagedList<ServiceItem>> getServicesByCategory({
    required String name
  }) async {
    final response = await _appApiService.getServicesByCatalog(name);
    return PagedList(data: _serviceDataMapper.mapToListEntity(response?.data));
  }
// ----------------------------------------------------------------
//appointment
  @override
  Future<List<TimeSlot>> getTimeSlot(String ServiceId) async {
    final response = await _appApiAppointment.getTimeSlot(serviceId: ServiceId);
    return _apiTimeSlotMapper.mapToListEntity(response?.data);
  }

  @override
  Future<AppointmentCreate> createAppointment(
      {required String timeSlotId}) async {
    final token = await _appPreferences.accessToken;
    final user_id = _appPreferences.currentUser?.id;
    final response = await _appApiAppointment.createBooking(
        token: token, userId: user_id!, timeslotId: timeSlotId);
    return _apiCreateBookingMapper.mapToEntity(response?.data);
  }
  @override
  Future<List<AppointmentItem?>> getBookingSuccess() async{
    final token = await _appPreferences.accessToken;
    final response = await _appApiAppointment.getAppointSuccess(
        token: token);
    return _apiGetBookingMapper.mapToListEntity(response?.data);
  }
    @override
  Future<List<AppointmentItem?>> getBookingPending() async{
    final token = await _appPreferences.accessToken;
    final response = await _appApiAppointment.getAppointPending(
        token: token);
    return _apiGetBookingMapper.mapToListEntity(response?.data);
  }
    @override
  Future<List<AppointmentItem?>> getBookingCancle() async{
    final token = await _appPreferences.accessToken;
    final response = await _appApiAppointment.getAppointCancle(
        token: token);
    return _apiGetBookingMapper.mapToListEntity(response?.data);
  }

    @override
  Future<List<AppointmentItem?>> getBookingShopPending({required String shopId}) async{
    final token = await _appPreferences.accessToken;
    final response = await _appApiAppointment.getAppointPendingShop(
        shop_id: shopId,
        token: token);
    return _apiGetBookingMapper.mapToListEntity(response?.data);
  }
      @override
  Future<List<AppointmentItem?>> getBookingShopSuccess({required String shopId}) async{
    final token = await _appPreferences.accessToken;
    final response = await _appApiAppointment.getAppointSuccessShop(
        shopId: shopId,
        token: token);
    return _apiGetBookingMapper.mapToListEntity(response?.data);
  }

      @override
  Future<List<AppointmentItem?>> getBookingShopCancle({required String shopId}) async{
    final token = await _appPreferences.accessToken;
    final response = await _appApiAppointment.getAppointCancleShop(
        shop_id: shopId,
        token: token);
    return _apiGetBookingMapper.mapToListEntity(response?.data);
  }
      @override
  Future<bool> userUpdateCancle({required id}) async{
    final token = await _appPreferences.accessToken;
    final response = await _appApiAppointment.updateAppointCancle(
        token: token, appointId: id);
    return response;
  }
   Future<bool> shopUpdateCancle({required id}) async{
    final token = await _appPreferences.accessToken;
    return await _appApiAppointment.updateAppointCancle(
        token: token, appointId: id);

  }
     Future<bool> shopUpdateSuccess({required id}) async{
    final token = await _appPreferences.accessToken;
    return  await _appApiAppointment.updateAppointSuccess(
        token: token, appointId: id);
  }
}
