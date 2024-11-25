import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'bloc/booking.dart';
import 'package:resources/resources.dart';
import '../../app.dart';

@RoutePage()
class BookingPage extends StatefulWidget {
  const BookingPage({super.key, required this.service});
  final ServiceItem service;
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(LoadTimeList(serviceId: widget.service.id));
    context.read<BookingBloc>().add(
          DateSelected(date: DateFormat('yyyy-MM-dd').format(DateTime.now())),
        );
  }

  @override
  @override
  Widget build(BuildContext context) {
    final navigator = GetIt.I.get<AppNavigator>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 400,
        child: Column(
          children: [
            BlocBuilder<BookingBloc, BookingState>(
              builder: (context, state) {
                context.read<BookingBloc>().add(const InitialBookingPage());
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   DateFormat('EEEE, dd/MM/yyyy')
                    //       .format(state.days[state.selectedDayIndex]),
                    //   style: AppTextStyles.s16w600Black(),
                    // ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<BookingBloc, BookingState>(
              builder: (context, state) {
                return Container(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.days.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          context.read<BookingBloc>().add(
                                SelectDay(dayIndex: index),
                              );

                          context.read<BookingBloc>().add(
                                DateSelected(
                                    date: DateFormat('yyyy-MM-dd')
                                        .format(state.days[index])),
                              );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          width: 60,
                          decoration: BoxDecoration(
                            color: state.selectedDayIndex == index
                                ? Colors.blue
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                DateFormat('dd').format(state.days[index]),
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: state.selectedDayIndex == index
                                      ? Colors.white
                                      : Colors.blue,
                                ),
                              ),
                              Text(
                                DateFormat('E').format(state.days[index]),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: state.selectedDayIndex == index
                                      ? Colors.white
                                      : Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            BlocBuilder<BookingBloc, BookingState>(
              // buildWhen: (previous, current) =>
              //     previous.selectedDate != current.selectedDate  ,
              builder: (context, state) {
                final filteredTimes = state.times.where((time) {
                  return time['slot_date'] == state.selectedDate;
                }).toList();
                return Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2.5,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: filteredTimes.length,
                    itemBuilder: (context, index) {
                      final time = filteredTimes[index];
                      final isDisabled = (time['available'] == null
                          ? false
                          : !(time['available'] as int > 0));
                      return GestureDetector(
                        onTap: isDisabled
                            ? null
                            : () {
                                context
                                    .read<BookingBloc>()
                                    .add(SelectTime(timeIndex: index));
                                 context
                                    .read<BookingBloc>()
                                    .add(TimeSlotSelected(timeslot: time));
                              },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isDisabled
                                ? Colors.grey[300]
                                : (state.selectedTimeIndex == index
                                    ? Colors.blue
                                    : Colors.white),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            time['start_time'] as String,
                            style: TextStyle(
                              color: isDisabled
                                  ? Colors.grey
                                  : (state.selectedTimeIndex == index
                                      ? Colors.white
                                      : Colors.blue),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            // Cancle and Accept button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100],
                    foregroundColor: Colors.blue,
                  ),
                  child: Text(S.current.cancel),
                ),
                const SizedBox(
                  width: Dimens.d16,
                ),
                BlocBuilder<BookingBloc, BookingState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state.selectedTimeIndex != -1
                          ? () {
                              Navigator.pop(context);
                              navigator.push(AppRouteInfo.appointconform(
                                  widget.service,
                                  state.timeslot
                                  ));
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: Text(S.current.booking),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
