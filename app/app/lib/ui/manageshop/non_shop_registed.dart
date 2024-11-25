import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class NonShopRegisted extends StatelessWidget {
  const NonShopRegisted({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: [
        Container(
          width: Dimens.d100,
          child: Image.asset(ImgConstants.register_shop),
        ),
        const SizedBox(height: 10,),
        Text('Chào mừng đến với BeautyQueen',style: AppTextStyles.s16w600Black(),),
        const SizedBox(height: 8,),
        Text('Hãy bắt đầu đăng ký ngay để quản lý cửa hàng của bạn', style: AppTextStyles.s14w400Black(),),
        const SizedBox(height: Dimens.d18,),
       Container(
        width: Dimens.d150,
        height: Dimens.d50,
        child:  CommonButton(isText: true, text: 'Đăng Ký Ngay', onPressed: (){}, backgroundColor: ColorConstant.primaryButton,style: AppTextStyles.s16w700White(), width: Dimens.d80, height: Dimens.d32,isLoading: false,),
      )
      ],),
    );
  }
}


// class StoreInfoCard extends StatelessWidget {
//   final String storeName;
//   final String storeSlogan;
//   final VoidCallback onDetailsPressed;

//   const StoreInfoCard({
//     required this.storeName,
//     required this.storeSlogan,
//     required this.onDetailsPressed,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: 30,
//           backgroundImage: AssetImage(Config.senShop),
//         ),
//         SizedBox(width: 10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(storeName,
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             Text(storeSlogan,
//                 style: TextStyle(fontSize: 14, color: Colors.grey)),
//           ],
//         ),
//         Spacer(),
//         ElevatedButton(
//           style: ButtonStyle(
//               backgroundColor: MaterialStateProperty.all(AppColor.common)),
//           onPressed: onDetailsPressed,
//           child: TextCustom()
//               .textCommon('Chi tiết', 16, AppColor.white, FontWeight.w500),
//         ),
//       ],
//     );
//   }
// }

// class AppointmentCard extends StatelessWidget {
//   final String title;
//   final int count;
//   bool? isNew = false;

//   AppointmentCard({
//     required this.title,
//     required this.count,
//     this.isNew,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: AppColor.c333,
//       child: Column(
//         children: [
//           isNew == false ?   Text(
//                 count.toString(),
//                 style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: AppColor.black),
//               ):
//           Stack(
//             children: [
//               Container(
//                 padding: EdgeInsets.all(8),
//                 child: Text(
//                   count.toString(),
//                   style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: AppColor.black),
//                 ),
//               ),
//               Positioned(
//                 top: 8,
//                 left: 15,
//                   child: Icon(
//                   size: 12,
//                 Icons.circle,
//                 color: AppColor.red,
//               ))
//             ],
//           ),
//           Text(
//             title,
//             style: TextStyle(fontSize: 14, color: AppColor.black),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class FeatureCard extends StatelessWidget {
//   final String title;
//   final String imagePath;
//   final VoidCallback onPressed;

//   const FeatureCard({
//     required this.title,
//     required this.imagePath,
//     required this.onPressed,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Column(
//         children: [
//           Image.asset(imagePath, height: 60),
//           SizedBox(height: 5),
//           Text(
//             title,
//             style: TextStyle(fontSize: 14, color: Colors.black),
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ManageStoreScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: const Icon(Icons.arrow_back),
//         title: Text('Quản lý cửa hàng'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.notifications),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Container(
//         color: AppColor.bghome,
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               Container(
//                 color: AppColor.white,
//                 padding: EdgeInsets.all(16),
//                 child: StoreInfoCard(
//                   storeName: 'Sen Shop',
//                   storeSlogan: 'Slogan of shop',
//                   onDetailsPressed: () {
//                     // Handle details press
//                   },
//                 ),
//               ),
//               SizedBox(height: 20),
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 16),
//                 color: AppColor.white,
//                 child:  Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     AppointmentCard(
//                         title: 'Chờ xác nhận', count: 1, isNew: true,),
//                     AppointmentCard(
//                         title: 'Đã xác nhận', count: 0, isNew: false,),
//                     AppointmentCard(
//                         title: 'Đã hoàn tất', count: 0, isNew: false,),
//                     AppointmentCard(
//                         title: 'Lịch sử', count: 0, isNew: false,),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.only(top: 30),
//                   color: AppColor.white,
//                   child: GridView.count(
//                     crossAxisCount: 2,
//                     childAspectRatio: 1.5,
//                     mainAxisSpacing: 16,
//                     crossAxisSpacing: 16,
//                     children: [
//                       FeatureCard(
//                         title: 'Dịch vụ của cửa hàng',
//                         imagePath: Config.icon_service,
//                         onPressed: () {
//                           // Handle service press
//                         },
//                       ),
//                       FeatureCard(
//                         title: 'Quảng Cáo',
//                         imagePath: Config.icon_advertising,
//                         onPressed: () {
//                           // Handle advertisement press
//                         },
//                       ),
//                       FeatureCard(
//                         title: 'Thống kê doanh số',
//                         imagePath: Config.icon_statistics,
//                         onPressed: () {
//                           // Handle decoration press
//                         },
//                       ),
//                       FeatureCard(
//                         title: 'Quản lý nhân viên',
//                         imagePath: Config.icon_employee,
//                         onPressed: () {
//                           // Handle customer management press
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
