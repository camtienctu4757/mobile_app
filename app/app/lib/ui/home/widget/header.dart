import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared/shared.dart';
import 'package:resources/resources.dart';
import '../bloc/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Header extends StatelessWidget {
  Header({super.key});
  
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: ColorConstant.gradient,
      ),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            flex: 3,
            child: Container(
              child: Image.asset(
                ImgConstants.logo_img,
              ),
              width: 70,
              height: kToolbarHeight + 10,
            ),
          ),
          Flexible(flex: 1, child: Container()),
          Flexible(
            flex: 7,
            child: Container(
              alignment: Alignment.center,
              height: kToolbarHeight - 10,
              width: 250,
              child: TextField(
                controller: searchController,
                obscureText: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: ColorConstant.unselectedItemColor,
                  ),
                  fillColor: ColorConstant.white,
                  filled: true,
                  alignLabelWithHint: true,
                  hintText: S.current.searching,
                  contentPadding: const EdgeInsets.all(10),
                  hintStyle:
                      const TextStyle(color: ColorConstant.unselectedItemColor),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    searchController.clear();
                    context
                        .read<HomeBloc>()
                        .add(SearchQueryChanged(query: value));
                  } else {
                    context.read<HomeBloc>().add(HomePageInitiated());
                  }
                },
                // onChanged: (value) {
                //   // Thực hiện tìm kiếm khi người dùng nhập
                //   _performSearch(value);
                //   //context.read<HomeBloc>().add(HomeEvent.searchQueryChanged(query: value));
                // }),
              ),
            ),
          )
        ],
      ),
    );
  }

  // void _performSearch(String query) {
  //   if (query.isEmpty) {
  //     print('No query provided');
  //   } else {
  //     print('Searching for: $query');
  //     // // Ví dụ: bloc.add(SearchServicesEvent(query: query));
  //   }
  // }
}
