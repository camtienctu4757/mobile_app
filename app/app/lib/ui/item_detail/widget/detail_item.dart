import 'package:app/ui/item_detail/bloc/item_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:app/ui/booking/bloc/booking.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/shared.dart';
import 'package:resources/resources.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/app.dart';

class ItemDetail extends StatefulWidget {
  const ItemDetail({super.key, required this.service});
  final ServiceItem service;
  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: ButtonBack(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: ColorConstant.bg_home,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Container(
              color: ColorConstant.bg_home,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: ColorConstant.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          BlocBuilder<ItemDetailBloc, ItemDetailState>(
                            builder: (context, state) {
                              return CarouselSlider(
                                items: state.ImageServiceList?.map((imageData) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child:  Image.memory(
                                                imageData,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              )
                                            
                                      );
                                    },
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                  height: 300, 
                                  enlargeCenterPage:
                                      true, 
                                  autoPlay: true, 
                                  aspectRatio: 16 / 9,
                                  viewportFraction: 0.8, 
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                widget.service.name,
                                style: AppTextStyles.s16w600Black(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: Dimens.d8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Text(
                                  AppUtils.formatCurrency(
                                          widget.service.price.toDouble())
                                      .toString(),
                                  style: AppTextStyles.s14w400Price(),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text(
                                  'Rẻ Vô Địch',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(Icons.whatshot, color: Colors.red),
                              ],
                            ),
                          ),
                          // const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: ColorConstant.white,
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage(ImgConstants
                                .shop), // replace with your avatar URL
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Skin Salon',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: ColorConstant.text_333,
                                  ),
                                  Text(
                                    'TP Vĩnh Long',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    color: ColorConstant.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              textAlign: TextAlign.left,
                              'Mô tả',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              widget.service.description,
                              style: AppTextStyles.s14w400Black(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(16)),
                          ),
                          isScrollControlled: true,
                          builder: (context) {
                            return BookingPage(
                              service: widget.service,
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.calendar_month_outlined,
                              color: ColorConstant.white),
                          const SizedBox(width: 8),
                          Text(
                            S.current.bookingnow,
                            style: AppTextStyles.s18w400White(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
