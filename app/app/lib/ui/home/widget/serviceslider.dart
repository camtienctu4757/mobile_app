// import 'package:app/ui/home/bloc/home.dart';
// import 'package:app/ui/home/bloc/home_event.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared/shared.dart';
// import 'package:resources/resources.dart';
// import 'package:app/app.dart';
// import '../bloc/home.dart';

// class CaterogSlider extends StatefulWidget {
//   const CaterogSlider({super.key});

//   @override
//   State<CaterogSlider> createState() => _CaterogSliderState();
// }

// class _CaterogSliderState extends State<CaterogSlider> {
//   final List<Map<String, String>> caterogy = [
//     {
//       'title': S.current.hair,
//       'image': 'assets/images/hair.png',
//       'id': '1'
//     },
//     {
//       'title': S.current.spa,
//       'image': 'assets/images/spa.png',
//       'id': '2'
//     },
//     {
//       'title': S.current.nail,
//       'image': 'assets/images/nail.png',
//       'id': '3'
//     },
//     {
//       'title': S.current.makeup,
//       'image': 'assets/images/makeup.png',
//       'id':'4'
//     },
//     {
//       'title': S.current.lips,
//       'image': 'assets/images/lips.png',
//       'id':'5'
//     },
//     {
//       'title': S.current.skin,
//       'image': 'assets/images/skin.png',
//       'id':'6'
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 5),
//       height: Dimens.d100.responsive(),
//       color: ColorConstant.white,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: caterogy.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//                 final selectedCategory = caterogy[index]['id'];
//               context.read<HomeBloc>().add(CategorySelected(category: selectedCategory!));
//             },
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 10),
//                   width: Dimens.d60.responsive(),
//                   height: Dimens.d60.responsive(),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     image: DecorationImage(
//                       image: AssetImage(caterogy[index]['image']!),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(caterogy[index]['title']!,style:AppTextStyles.s16w600Primary()),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
