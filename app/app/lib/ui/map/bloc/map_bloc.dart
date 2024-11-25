import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:app/app.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
@Injectable()
class MapBloc extends BaseBloc<MapEvent, MapState> {
  MapBloc() : super(const MapState()) {
     on<PickerChange>(
      _onPickerChange,
      transformer: distinct(),
    );
    on<LocationSearch>(
      _onLocationSearch,
      transformer: distinct(),
    );
  }
void _onPickerChange(PickerChange event, Emitter<MapState> emit) {
    emit(state.copyWith(onPick:event.lat));
  }


  void _onLocationSearch(LocationSearch event, Emitter<MapState> emit) async {
    final latLng = await getLatLngFromAddress(event.address); // Lấy tọa độ từ API
  if (latLng != null) {
    emit(state.copyWith(onPick: latLng)); // Cập nhật trạng thái với tọa độ mới
  } else {
    // Xử lý trường hợp không tìm được tọa độ, ví dụ như thông báo lỗi cho người dùng
    print('Không thể tìm thấy địa chỉ');
  }
  }



Future<LatLng?> getLatLngFromAddress(String address) async {
  const String apiKey = 'AIzaSyD62LKrHsMu71B92ZHL3UWU2PNXHaSog6s';
  final String url =
      'https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$apiKey';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    if (data['status'] == 'OK') {
      final lat = data['results'][0]['geometry']['location']['lat'];
      final lng = data['results'][0]['geometry']['location']['lng'];
      return LatLng(lat, lng);
    } else {
      print('Geocoding error: ${data['status']}');
      return null;
    }
  } else {
    print('Request failed with status: ${response.statusCode}');
    return null;
  }
}

}
