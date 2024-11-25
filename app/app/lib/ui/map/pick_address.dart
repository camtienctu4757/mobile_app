// import 'package:app/ui/map/bloc/map.dart';
// import 'package:flutter/material.dart';
// import 'package:auto_route/auto_route.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import 'package:location/location.dart';
// import 'package:app/app.dart';
// import 'package:shared/shared.dart';
// // void _fetchLocationUpdate() async {
// //   bool serviceEnable;
// //   PermissionStatus permissionGranted;
// //   serviceEnable = await locationController.serviceEnabled();
// //   if (serviceEnable) {
// //     serviceEnable = await locationController.requestService();
// //   } else {
// //     return;
// //   }
// //   permissionGranted = await locationController.hasPermission();
// //   if (permissionGranted == PermissionStatus.denied) {
// //     permissionGranted = await locationController.requestPermission();
// //     if (permissionGranted != PermissionStatus.granted) {
// //       return;
// //     }
// //   }
// //   locationController.onLocationChanged.listen((currenlocation) {
// //     if (currenlocation.latitude != null && currenlocation.longitude != null) {
// //       bloc.add(PickerChange(
// //           lat: LatLng(currenlocation.latitude!, currenlocation.longitude!)));
// //     }
// //     logD('${currenlocation.latitude!},${currenlocation.longitude!}');
// //   });
// // }
// // }

// @RoutePage()
// class AddressSelectionPage extends StatefulWidget {
//   @override
//   State<AddressSelectionPage> createState() => _AddressSelectionPageState();
// }

// class _AddressSelectionPageState
//     extends BasePageState<AddressSelectionPage, MapBloc> {
//   late GoogleMapController mapController;
//   final TextEditingController _addressController = TextEditingController();

//   void _onMapCreate(GoogleMapController controller) {
//     mapController = controller;
//   }

//   @override
//   Widget buildPage(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chọn địa chỉ'),
//       ),
//       body: BlocBuilder<MapBloc, MapState>(
//         builder: (context, state) {
//           return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: SizedBox(
//                         child: TextField(
//                             controller: _addressController,
//                             decoration: InputDecoration(
//                                 contentPadding: const EdgeInsets.symmetric(
//                                     horizontal: Dimens.d8),
//                                 hintText: 'Nhập địa chỉ ...',
//                                 hintStyle: AppTextStyles.s14w400Hint(),
//                                 filled: true,
//                                 fillColor: ColorConstant.bg_textfiled,
//                                 border: OutlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.circular(Dimens.d10),
//                                   borderSide: BorderSide.none,
//                                 )),
//                             keyboardType: TextInputType.text,
//                             onSubmitted: (value) {
//                               if (value.isNotEmpty) {
//                                 // mapController.animateCamera(
//                                 //     CameraUpdate.newLatLngZoom(
//                                 //         state.onPick, 15.0));
//                                 bloc.add(LocationSearch(address: value));
//                               }
//                             }),
//                       ),
//                     ),
//                     Container(
//                       // color: ColorConstant.bg_button_booking,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(Dimens.d100),
//                           color: ColorConstant.primaryButton),
//                       child: IconButton(
//                         color: ColorConstant.secondary,
//                         icon: Icon(Icons.search),
//                         onPressed: () {
//                           if (_addressController.text.isNotEmpty) {
//                             //  mapController.animateCamera(CameraUpdate.newLatLngZoom(state.onPick, 15.0));
//                             // _searchLocation(context, _addressController.text);
//                             print("text");
//                           }
//                         },
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: GoogleMap(
//                   onMapCreated: _onMapCreate,
//                   initialCameraPosition: CameraPosition(
//                     target: state.onPick,
//                     zoom: 15.0,
//                   ),
//                   markers: {
//                     Marker(
//                       markerId: MarkerId('selectedLocation'),
//                       position: state.onPick,
//                     ),
//                   },
//                   onTap: (LatLng newPosition) {
//                     bloc.add(PickerChange(lat: newPosition));
//                   },
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
