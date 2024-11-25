import 'package:app/ui/storetab/bloc/storetab.dart';
import 'package:app/ui/storetab/bloc/storetab_event.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';
import '../../app.dart';
import 'bloc/my_shop_list.dart';

@RoutePage()
class MyShopListPage extends StatefulWidget {
  const MyShopListPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _MyShopListPageState();
  }
}

class _MyShopListPageState
    extends BasePageState<MyShopListPage, MyShopListBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return CommonScaffold(
      body: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            S.current.storemanagement,
            style: AppTextStyles.s18w700Primary(),
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                  image: AssetImage(ImgConstants.shop_manage_baner),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  S.current.yourshoplist,
                  style: AppTextStyles.s16wBoldPrimary(),
                ),
              ),
            ),
            BlocBuilder<StoreBloc, StoreState>(
              buildWhen: (previous, current) =>
                  previous.loadShopList != current.loadShopList,
              builder: (context, state) {
                return Expanded(
                    child: ListView.builder(
                  itemCount: state.loadShopList.length,
                  itemBuilder: (context, index) {
                    final shop = state.loadShopList[index];
                    if (!state.shopImages.containsKey(shop.id)) {
                      context.read<StoreBloc>().add(
                          LoadShopImage(queryParameters: {"shop_id": shop.id}));
                    }
                    return GestureDetector(
                      onTap: () {
                        navigator.push(AppRouteInfo.shopmanage(
                            shop, state.shopImages[shop.id]));
                      },
                      child: ShopCard(
                        shop_id: shop.id,
                        shopName: shop.name,
                      ),
                    );
                  },
                ));
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstant.third,
          shape: CircleBorder(),
          onPressed: () async {
            await navigator.push(const AppRouteInfo.registerShop());
          },
          child: const Icon(
            Icons.add,
            color: ColorConstant.primary,
          ),
        ),
      ),
    );
  }
}

class ShopCard extends StatefulWidget {
  final String shop_id;
  final String shopName;
  const ShopCard({super.key, required this.shopName, required this.shop_id});

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends BasePageState<ShopCard, MyShopListBloc> {
  @override
  Widget buildPage(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: ListTile(
        leading: BlocBuilder<StoreBloc, StoreState>(
          builder: (context, state) {
            final imageData = state.shopImages[widget.shop_id];
            return CircleAvatar(
              radius: 20,
              backgroundImage: imageData != null
                  ? MemoryImage(imageData) as ImageProvider<Object>
                  : const AssetImage(ImgConstants.default_shop)
                      as ImageProvider<Object>,
            );
          },
        ),
        title: Text(
          widget.shopName,
          style: AppTextStyles.s16w500Normal(),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline_sharp),
          onPressed: () {
            context.read<StoreBloc>().add(DeleteShop(shopId: widget.shop_id));
            context.read<StoreBloc>().add(const StoreTabInitiated());
          },
        ),
      ),
    );
  }
}
