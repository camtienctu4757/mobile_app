import 'package:app/ui/storetab/bloc/nonshop_bloc.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:app/app.dart';

class NonShopPage extends StatefulWidget {
  const NonShopPage({super.key});

  @override
  State<NonShopPage> createState() => _NonShopPageState();
}

class _NonShopPageState extends BasePageState<NonShopPage, NonShopBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Center(
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
          Text(
            'Chào mừng đến với BeautyQueen',
            style: AppTextStyles.s16w600Black(),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Hãy bắt đầu đăng ký ngay để quản lý cửa hàng của bạn',
            style: AppTextStyles.s14w400Black(),
          ),
          const SizedBox(
            height: Dimens.d18,
          ),
          Container(
            width: Dimens.d150,
            height: Dimens.d50,
            child: CommonButton(
              isText: true,
              text: 'Đăng Ký Ngay',
              onPressed: () {
                navigator.push(const AppRouteInfo.registerShop());
              },
              backgroundColor: ColorConstant.primaryButton,
              style: AppTextStyles.s16w700White(),
              width: Dimens.d80,
              height: Dimens.d32,
              isLoading: false,
            ),
          )
        ],
      ),
    );
  }
}
