import 'package:app/app.dart';
import 'package:app/resource/styles/app_text_styles.dart';
import 'package:app/shared_view/button_back.dart';
import 'package:app/ui/appointment/bloc/appointment.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:resources/resources.dart';
import 'package:intl/intl.dart';
import 'package:shared/shared.dart';
import 'bloc/booking.dart';

@RoutePage()
class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage(
      {super.key, required this.timeslot, required this.service});
  final ServiceItem service;
  final Map<String, Object> timeslot;
  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  final navigator = GetIt.I.get<AppNavigator>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ButtonBack(),
        title: Text(S.current.conform),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionTitle(S.current.bookininfor),
                  // IconButton(
                  //   icon: const Icon(Icons.edit),
                  //   onPressed: () {},
                  // ),
                ],
              ),
              const Divider(
                color: ColorConstant.text_333,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              _buildServiceItem(
                  ImgConstants.default_image,
                  widget.service.name,
                  widget.service.description,
                  1,
                  AppUtils.formatCurrency(widget.service.price.toDouble())),
              _buildAppointmentDetail(
                  Icons.calendar_today,
                  AppUtils.formatDate(
                      DateTime.parse(widget.timeslot['slot_date'].toString()))),
              _buildAppointmentDetail(
                  Icons.access_time, widget.timeslot['start_time'].toString()),
              _buildAppointmentDetail(Icons.location_on,
                  'số 50, đường Phạm Thái Bường, phường 4, thành phố Vĩnh Long'),
              const SizedBox(height: 20),
              const Divider(
                color: ColorConstant.text_333,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              // Row(
              //   children: [
              //     _buildSectionTitle('Khuyến mãi'),
              //     Container(
              //         height: 40,
              //         child: Image.asset(
              //           ImgConstants.sale_icon,
              //           fit: BoxFit.contain,
              //         ))
              //   ],
              // ),
              // _buildDiscountDetail(),
              // _buildDiscountDetail(),
              // const SizedBox(height: 20),
              const Divider(
                color: ColorConstant.text_333,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              _buildSectionTitle('Thanh toán'),
              _paymentItem(
                  widget.service.name + '    x1', 1, widget.service.price),
              // _paymentItem('Gội đầu thư giãn' + '   x1', 1, 40000),
              // _paymentItem('Giá giảm' + '   x1', 1, -10000, isDiscount: true),
              const Divider(
                color: ColorConstant.text_333,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    S.current.total,
                    style: AppTextStyles.s16w600Black(),
                  ),
                  Text(
                      NumberFormat.currency(locale: 'vi', symbol: '')
                              .format(widget.service.price) +
                          'VND',
                      style: AppTextStyles.s14w400Price())
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<BookingBloc>().add(AppointButtonPress(
                        timeslotId: widget.timeslot['id'].toString()));
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(S.current.bookingsucessfully)));
                    Future.delayed(const Duration(seconds: 3), () {
                      context
                          .read<AppointmentBloc>()
                          .add(const LoadAppointmentsPending());
                      navigator.popUntilRootOfCurrentBottomTab();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.primary,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 48.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    S.current.bookingappoint,
                    style: AppTextStyles.s16wboldWhite(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildSectionTitle(String title) {
  return Text(
    title,
    style: const TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
  );
}

Widget _buildAppointmentDetail(IconData icon, String detail) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        Icon(icon, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            detail,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

Widget _buildServiceItem(String image, String serviceName,
    String serviceDescription, int quantity, String price) {
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.grey.shade200,
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(image),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text(serviceName), Text('x' + quantity.toString())],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      maxLines: 1,
                      serviceDescription,
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    price.toString(),
                    style: AppTextStyles.s14w400Price(),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDiscountDetail() {
  return Container(
    margin: const EdgeInsets.all(5),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.grey.shade200,
    ),
    child: Row(
      children: [
        Radio(
          value: 1,
          groupValue: 0,
          onChanged: (value) {},
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'Giảm 10% khi đặt cùng dịch vụ gội đầu thư giãn',
            style: TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(width: 10),
      ],
    ),
  );
}

Widget _paymentItem(String title, int quantity, double price,
    {bool isDiscount = false}) {
  return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    SizedBox(
      width: 250,
      child: Text(
        title,
        style: TextStyle(
            fontSize: 16,
            color: isDiscount ? Colors.red : Colors.black,
            overflow: TextOverflow.ellipsis),
      ),
    ),
    Text(
      NumberFormat.currency(locale: 'vi', symbol: '')
          .format(price * quantity)
          .toString(),
      style: TextStyle(
        fontSize: 16,
        color: isDiscount ? Colors.red : Colors.black,
      ),
    )
  ]);
}
