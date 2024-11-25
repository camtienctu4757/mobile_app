import 'package:app/ui/appointment/bloc/appointment_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared/shared.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app.dart';
import 'bloc/appointment.dart';
import 'package:resources/resources.dart';

@RoutePage()
class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AppointmentPageState();
  }
}

class _AppointmentPageState extends State<AppointmentPage> {
  @override
  void initState() {
    super.initState();
    context.read<AppointmentBloc>().add(const LoadAppointmentsPending());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.allappointments,
          style: AppTextStyles.s18w700Primary(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder<AppointmentBloc, AppointmentState>(
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildToggleButton(
                        text: S.current.successbooking,
                        index: 0,
                        isActive: state.tabIndex == 0),
                    _buildToggleButton(
                        text: S.current.upcomming,
                        index: 1,
                        isActive: state.tabIndex == 1),
                    _buildToggleButton(
                        text: S.current.canclebooking,
                        index: 2,
                        isActive: state.tabIndex == 2),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<AppointmentBloc, AppointmentState>(
              builder: (context, state) {
                if (state.appointments_list.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: state.appointments_list.length,
                        itemBuilder: (context, index) => _buildAppointmentCard(
                            state.appointments_list[index]!)),
                  );
                } else {
                  return Expanded(child: _builfNoBooking());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _builfNoBooking() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Dimens.d100,
            child: Image.asset(ImgConstants.no_booking),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            S.current.nobooking,
            style: AppTextStyles.s14w400Black(),
          ),
          const SizedBox(
            height: Dimens.d18,
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, bool isSelecte, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: isSelecte ? ColorConstant.primaryButton : Colors.blue[100],
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildToggleButton(
      {String text = '', int index = 1, bool isActive = false}) {
    return GestureDetector(
      onTap: () {
        context.read<AppointmentBloc>().add(AppointmentsTab(tabIndex: index));
        if (index == 1) {
          context.read<AppointmentBloc>().add(const LoadAppointmentsPending());
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue[100] : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? ColorConstant.secondary : Colors.grey[300]!,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isActive ? ColorConstant.primary : Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _buildAppointmentSection(
      String sectionTitle, String date, List<Widget> appointments) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionTitle,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              date,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Column(children: appointments),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildAppointmentCard(AppointmentItem appointment) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Color(0xFFF3F4F8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // CircleAvatar(
            //   radius: 28,
            //   backgroundImage: AssetImage(ImgConstants.nail_img),
            // ),
            // const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appointment.serviceName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Giờ: ' + appointment.appointmentTime.substring(0, 5),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Thời gian thực hiện: " +
                        appointment.duration.toString() +
                        " phút",
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Ngày: " +
                        DateFormat('dd-MM-yyyy').format(
                            DateTime.parse(appointment.appointmentDate)),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 158, 158, 158),
                    ),
                  ),
                  Text(
                    "Cửa hàng: " + appointment.storeName,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Địa chỉ: " + appointment.storeAddress,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                      "Giá :" +
                          AppUtils.formatCurrency(appointment.price).toString(),
                      style: AppTextStyles.s14w400Price()),
                ],
              ),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: ColorConstant.secondary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.cancel),
                color: Colors.white,
                onPressed: () {
                  context
                      .read<AppointmentBloc>()
                      .add(PressCancleAppointment(appoint_id: appointment.id));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
