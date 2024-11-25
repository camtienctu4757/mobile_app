import 'package:app/app.dart';
import 'bloc/shop_manage.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/shared.dart';
import 'package:domain/domain.dart';
import 'dart:typed_data';
import 'package:resources/resources.dart';

@RoutePage(name: 'ShopManageRoute')
class ShopManagePage extends StatefulWidget {
  const ShopManagePage({super.key, required this.shop, this.image});
  final Shop shop;
  final Uint8List? image;
  @override
  State<ShopManagePage> createState() => _ShopManagePageState();
}

class _ShopManagePageState
    extends BasePageState<ShopManagePage, ShopManageBloc> {
  List tile = [
    S.current.servicemanagement,
    S.current.pr,
    S.current.monthreport,
    S.current.staffmanagement
  ];
  List icon = [
    Icons.home_repair_service_outlined,
    Icons.campaign,
    Icons.receipt_long,
    Icons.people_outlined
  ];
  @override
  Widget buildPage(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopManageBloc(
        GetIt.I.get<GetImageShopUseCase>(),
        GetIt.I.get<ShopUpdateBookingCancleUsecase>(),
        GetIt.I.get<ShopUpdateSuccessUseCase>(),
        )
        ..add(LoadShopImage(queryParameters: {'shop_id': widget.shop.id})),
      child: CommonScaffold(
          appBar: AppBar(
            leading: IconButton(
              color: ColorConstant.primary,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                navigator.pop();
              },
            ),
            title: Text(S.current.storemanagement,
                style: AppTextStyles.s18w700Primary()),
            centerTitle: true,
          ),
          body: Container(
            height: double.infinity,
            color: ColorConstant.bg_home,
            child: SingleChildScrollView(
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.only(top: Dimens.d8),
                  color: ColorConstant.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        BlocBuilder<ShopManageBloc, ShopManageState>(
                          builder: (context, state) {
                            return CircleAvatar(
                              radius: 30,
                              backgroundImage: state.imageData != null
                                  ? MemoryImage(state.imageData!)
                                      as ImageProvider<Object>
                                  : AssetImage(ImgConstants.default_shop)
                                      as ImageProvider<Object>,
                            );
                          },
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.shop.name,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                widget.shop.email,
                                style:
                                    TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        // ElevatedButton(
                        //   onPressed: () {},
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: ColorConstant.bg_button_primary,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //   ),
                        //   child: Text(
                        //     S.current.storedetail,
                        //     style: AppTextStyles.s16w600White(),
                        //   ),
                        // ),
                        CustomElevateButton(
                          bgColor: ColorConstant.bg_button_primary,
                          isIcons: true,
                          onpress: () {},
                          textColor: Colors.white,
                          icon: const Icon(Icons.edit),
                          iconColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),

                // Divider(),

                // Các mục của cuộc hẹn
                Container(
                  margin: const EdgeInsets.only(top: Dimens.d8),
                  color: ColorConstant.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildAppointmentStatus(
                            S.current.waitingappoint, '1', true),
                        _buildAppointmentStatus(
                            S.current.acceptappoint, '0', false),
                        _buildAppointmentStatus(
                            S.current.cancleappoint, '0', false),
                        _buildAppointmentStatus(S.current.history, '0', false),
                      ],
                    ),
                  ),
                ),
                // Divider(),
                // Các mục quản lý
                Container(
                    margin: const EdgeInsets.only(top: Dimens.d8),
                    color: ColorConstant.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.count(
                          shrinkWrap:
                              true, // Giúp GridView tự điều chỉnh kích thước
                          physics:
                              NeverScrollableScrollPhysics(), // Tắt cuộn cho GridView
                          primary: false,
                          padding: const EdgeInsets.all(8),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          crossAxisCount: 2,
                          children: [
                            _buildFeatureButton(
                                S.current.servicemanagement,
                                Icons.home_repair_service_outlined,
                                widget.shop.id),
                            _buildFeatureButton(
                                S.current.pr, Icons.campaign, widget.shop.id),
                            _buildFeatureButton(S.current.monthreport,
                                Icons.receipt_long, widget.shop.id),
                            _buildFeatureButton(S.current.staffmanagement,
                                Icons.people_outlined, widget.shop.id),
                          ]),
                    ))
              ]),
            ),
          )),
    );
  }

  Widget _buildAppointmentStatus(
      String title, String count, bool isHighlighted) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isHighlighted ? Colors.red : Colors.black,
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildFeatureButton(String title, IconData icon, String? shopId) {
    return GestureDetector(
      onTap: () {
        // switch (title) {
        //   case S.current.servicemanagement:
        //     navigator.push(AppRouteInfo.servicemanage());
        //     break;

        // }
        if (title == S.current.servicemanagement) {
          navigator.push(AppRouteInfo.servicemanage(shopId!));
        }
      },
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 40, color: Colors.blue),
          ),
          SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
