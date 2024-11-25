import 'package:app/resource/styles/app_text_styles.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared/shared.dart';
import '../../app.dart';
import 'bloc/notify.dart';
import 'package:resources/resources.dart';

@RoutePage()
class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState
    extends BasePageState<NotificationPage, NotificationBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      appBar: AppBar(
          // centerTitle: true,
          title: Text(
            S.current.notification,
            style: AppTextStyles.s18w700Primary(),
          ),
          actions: [
            IconButton(
              icon:
                  const Icon(Icons.notifications, color: ColorConstant.primary),
              onPressed: () {},
            ),
          ]),
      body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: Dimens.d100,
            child: Image.asset(ImgConstants.register_shop),
          ),
          const SizedBox(
            height: 10,
          ),
          // Text(
          //   'Chào mừng đến với BeautyQueen',
          //   style: AppTextStyles.s16w600Black(),
          // ),
          // SizedBox(
          //   height: 8,
          // ),
          Text(
            'Tính năng sẽ được xây dựng trong thời gian tới',
            style: AppTextStyles.s14w400Black(),
          ),
          const SizedBox(
            height: Dimens.d18,
          ),
          
        ],
      ),
    )
      //  Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        // child: ListView.builder(
        //   itemCount: 5,
        //   itemBuilder: (context, index) {
        //     return NotificationItem(isread: index % 2 == 0? true: false,);
        //   },
        // ),
      // ),
    );
  }
}

class NotificationItem extends StatefulWidget {
  final bool isread;
  NotificationItem({super.key, required this.isread});
  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.d5),
      child: Card(
        elevation: (widget.isread == true ? 0:2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          // leading: CircleAvatar(
          //   backgroundImage: AssetImage(ImgConstants.sp3),
          // ),
          title:
              Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit', style: AppTextStyles.s16w600Black(),),
          subtitle:
              Text('Sed do eiusmod tempor incididunt ut labore et dolore.',  style: AppTextStyles.s16w600Light()),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lock_clock, size: 18),
              SizedBox(height: 4),
              Text('07:00 AM', style: TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
