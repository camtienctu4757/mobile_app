import 'dart:async';

import 'package:app/ui/item_detail/bloc/item_detail.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';
import 'package:app/ui/home/widget/header.dart';
import 'package:get_it/get_it.dart';
import '../../app.dart';
import 'bloc/home.dart';
// import 'widget/serviceslider.dart';

class _LoadingItem extends StatelessWidget {
  const _LoadingItem();

// build là hàm của StatefulWidget
  @override
  Widget build(BuildContext context) {
    return RounedRectangleShimmer(
      width: double.infinity,
      height: Dimens.d60.responsive(),
    );
  }
}

class _ListViewLoader extends StatelessWidget {
  const _ListViewLoader();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 0.7,
      ),
      itemCount: UiConstants.shimmerItemCount,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimens.d8.responsive(),
          vertical: Dimens.d4.responsive(),
        ),
        child: const ShimmerLoading(
          loadingWidget: _LoadingItem(),
          isLoading: true,
          child: _LoadingItem(),
        ),
      ),
    );
  }
}

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends BasePageState<HomePage, HomeBloc> {
  late final _pagingController = CommonPagingController<ServiceItem>()
    ..disposeBy(disposeBag);

  @override
  void initState() {
    super.initState();
    bloc.add(const HomePageInitiated());
    _pagingController.listen(
      onLoadMore: () => bloc.add(const ServiceLoadMore()),
    );
  }

  @override
  Widget buildPageListeners({required Widget child}) {
    return MultiBlocListener(
      listeners: [
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) =>
              previous.services != current.services,
          listener: (context, state) {
            _pagingController.appendLoadMoreOutput(state.services);
          },
        ),
        BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) =>
              previous.loadUsersException != current.loadUsersException,
          listener: (context, state) {
            _pagingController.error = state.loadUsersException;
          },
        ),
      ],
      child: child,
    );
  }

  @override
  Widget buildPage(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: ColorConstant.gradient,
      ),
      child: SafeArea(
        // minimum: EdgeInsets.symmetric(vertical: Dimens.d8),
        child: CommonScaffold(
          backgroundColor: ColorConstant.bg_home,
          body: RefreshIndicator(
            onRefresh: () async {
              final completer = Completer<void>();
              bloc.add(HomePageRefreshed(completer: completer));
              return await completer.future;
            },
            child: CustomScrollView(
              slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    minHeight: kToolbarHeight + 35,
                    maxHeight: kToolbarHeight + 35,
                    child: Header(),
                  ),
                ),
                // SliverPersistentHeader(
                //   pinned: true,
                //   delegate: _SliverAppBarDelegate(
                //     minHeight: 120.0,
                //     maxHeight: 130.0,
                //     child: const CaterogSlider(),
                //   ),
                // ),
                const SliverToBoxAdapter(
                  child: VerticalSlider(imgs: ImgConstants.img),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 8),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(8.0),
                  sliver: BlocBuilder<HomeBloc, HomeState>(
                    buildWhen: (previous, current) =>
                        previous.services != current.services ||
                        previous.isShimmerLoading != current.isShimmerLoading,
                    builder: (context, state) {
                      return state.isShimmerLoading &&
                              state.services.data.isEmpty
                          ? const SliverFillRemaining(child: _ListViewLoader())
                          : SliverGrid(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5,
                                childAspectRatio: 0.7,
                              ),
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final service = state.services.data[index];
                                  return GestureDetector(
                                    onTap: () async {
                                      await navigator.push(
                                          AppRouteInfo.itemDetail(service));
                                    },
                                    child: ItemService(service: service),
                                  );
                                },
                                childCount: state.services.data.length,
                              ),
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: maxExtent,
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
