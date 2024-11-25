import 'package:app/ui/home/bloc/home.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:app/app.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemService extends StatefulWidget {
  const ItemService({super.key, required this.service});
  final ServiceItem service;
  @override
  State<StatefulWidget> createState() => _ItemServiceState();
}

class _ItemServiceState extends BasePageState<ItemService, HomeBloc> {
  // late final AppNavigator navigator = GetIt.instance.get<AppNavigator>();
  // @override
  // void initState() {
  //   super.initState();
  //   bloc.add(ServiceLoadImage(path: '', queryParameters: {
  //     "file_id": widget.service.photos[0].fileUuid,
  //     "service_id": widget.service.id
  //   }));
  // }

  @override
  Widget buildPage(BuildContext context) {
    if (widget.service.photos.isNotEmpty) {
      bloc.add(ServiceLoadImage(path: '', queryParameters: {
        "file_id": widget.service.photos[0].fileUuid,
        "service_id": widget.service.id
      }));
    }

    return Container(
      height: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.d10)),
          color: ColorConstant.white),
      child: Column(
        children: [
          // Container(
          //   // padding: EdgeInsets.all(5),
          //   height: Dimens.d150,
          //   width: double.infinity,
          //   // child: Image.asset(
          //   //   fit: BoxFit.fitHeight,
          //   //   service.photos,
          //   // ),
          // ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.imageData != null) {
                return Container(
                  height: Dimens.d150,
                  width: double.infinity,
                  child: Image.memory(
                    state.imageData!,
                    fit: BoxFit.fitHeight,
                  ),
                );
              }
              return Container(
                height: Dimens.d150,
                width: double.infinity,
                child: Image.asset(
                    fit: BoxFit.fitHeight, ImgConstants.default_image),
              );
            },
          ),
          const SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    widget.service.name,
                    style: AppTextStyles.s14w700Black(),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                      AppUtils.formatCurrency(widget.service.price.toDouble())
                          .toString(),
                      style: AppTextStyles.s14w400Price()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: Dimens.d60,
                      child: CommonButton(
                        isText: false,
                        onPressed: () async {
                          await navigator
                              .push(AppRouteInfo.appointbook(widget.service));
                        },
                        borderRadius: Dimens.d60,
                        icon: const Icon(
                          // size:Dimens.d25,
                          Icons.calendar_month_outlined,
                          color: ColorConstant.primary,
                        ),
                        backgroundColor: ColorConstant.bg_button_booking,
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
