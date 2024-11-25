import 'package:app/app.dart';
import 'package:app/ui/registershop/bloc/registershop.dart';
import 'package:app/ui/registershop/bloc/registershop_event.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class RegisterStorePage extends StatefulWidget {
  @override
  State<RegisterStorePage> createState() => _RegisterStorePageState();
}

class _RegisterStorePageState
    extends BasePageState<RegisterStorePage, RegisterShopBloc> {
  Future<void> _selectTime(BuildContext context, String event) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.blue[50], // Match the background color
              hourMinuteColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected)
                      ? Colors.blue[200]!
                      : Colors.grey[200]!),
              hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected)
                      ? Colors.white
                      : Colors.black),
              dayPeriodColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected)
                      ? Colors.pink[100]!
                      : Colors.grey[200]!),
              dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
                  states.contains(MaterialState.selected)
                      ? Colors.black
                      : Colors.black54),
              dialHandColor: Colors.blue[700],
              dialBackgroundColor: Colors.grey[200],
              entryModeIconColor: Colors.black54,
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              dayPeriodShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (event == 'open') {
        context.read<RegisterShopBloc>().add(InputShopOpenTime(time: picked));
      } else {
        context.read<RegisterShopBloc>().add(InputShopCloseTime(time: picked));
      }
    }
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterShopBloc(
        GetIt.I.get<CreateShopUseCase>()
      ),
      child: CommonScaffold(
          appBar: AppBar(
            leading: ButtonBack(),
            title: Text(
              S.current.registershop,
              style: AppTextStyles.s16wBoldPrimary(),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Input(
                    name: S.current.shopname + "*",
                    hint: S.current.insertshopname,
                    onInput: TextInputType.text,
                    event: InputShopName(name: ''),
                  ),
                  const SizedBox(height: 16),
                  Input(
                    name: S.current.phone + "*",
                    hint: S.current.insertphone,
                    onInput: TextInputType.phone,
                    event: InputShopPhone(phone: ''),
                  ),
                  const SizedBox(height: 16),
                  Input(
                    name: S.current.shopcontact,
                    hint: "Email hoặc Facebook link",
                    onInput: TextInputType.text,
                    event: InputShopContact(contact: ''),
                  ),
                  const SizedBox(height: 16),
                  Input(
                    name: S.current.shopAddress,
                    hint: S.current.inseraddress,
                    onInput: TextInputType.text,
                    event: InputShopAddress(address: ''),
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<RegisterShopBloc, RegisterShopState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomElevateButton(
                            bgColor: ColorConstant.third,
                            isIcons: true,
                            onpress: () => _selectTime(context, 'open'),
                            textColor: ColorConstant.textblue,
                            icon: const Icon(Icons.alarm_on_outlined),
                            text: state.openTime == null
                                ? S.current.shopopentime
                                : formatTimeOfDay(state.openTime!),
                          ),
                          CustomElevateButton(
                            bgColor: ColorConstant.third,
                            isIcons: true,
                            onpress: () => _selectTime(context, 'close'),
                            textColor: ColorConstant.textblue,
                            icon: const Icon(Icons.door_sliding_outlined),
                            text: state.closedTime == null
                                ? S.current.shopclosetime
                                : formatTimeOfDay(state.closedTime!),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<RegisterShopBloc, RegisterShopState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(
                                    ColorConstant.primaryButton)),
                        onPressed: () {
                          bloc.add(RegisterShopButtonClick(
                              address: state.address,
                              open: state.openTime!,
                              close: state.closedTime!,
                              name: state.storeName,
                              phone: state.phone,
                              contact: state.contact));
                        },
                        child: Text(
                          S.current.registershop,
                          style: AppTextStyles.s16w600White(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class Input extends StatelessWidget {
  const Input(
      {super.key,
      required this.name,
      required this.hint,
      this.onChanged,
      required this.event,
      required this.onInput});
  final String name;
  final String hint;
  final Function? onChanged;
  final TextInputType onInput;
  final RegisterShopEvent event;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (event is InputShopName) {
          context.read<RegisterShopBloc>().add(InputShopName(name: value));
        } else if (event is InputShopPhone) {
          context.read<RegisterShopBloc>().add(InputShopPhone(phone: value));
        } else if (event is InputShopContact) {
          context
              .read<RegisterShopBloc>()
              .add(InputShopContact(contact: value));
        } else if (event is InputShopAddress) {
          context
              .read<RegisterShopBloc>()
              .add(InputShopAddress(address: value));
        }
        ;
      },
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: ColorConstant.primary),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorConstant.primary), // Màu khi focus
        ),
        labelText: name,
        hintText: hint,
      ),
      keyboardType: onInput,
    );
  }
}
