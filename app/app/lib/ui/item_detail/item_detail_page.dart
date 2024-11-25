import 'package:auto_route/auto_route.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app.dart';
import 'bloc/item_detail.dart';

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
        crossAxisCount: 5, 
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
class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({
    required this.service,
    super.key,
  });

  final ServiceItem service;

  @override
  State<StatefulWidget> createState() {
    return _ItemDetailPageState();
  }
}

class _ItemDetailPageState
    extends BasePageState<ItemDetailPage, ItemDetailBloc> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (widget.service.photos.isNotEmpty) {
    //   context.read<HomeBloc>().add(ServiceLoadImage(path: '', queryParameters: {
    //     "file_id": widget.service.photos[0].fileUuid,
    //     "service_id": widget.service.id
    //   }));
    // }
   
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ItemDetailBloc(
            GetIt.I.get<GetServicesUseCase>(),
            GetIt.I.get<GetImageUseCase>()
          )..add(LoadServiceImage(
        image_url: widget.service.photos, service_id: widget.service.id)),
      child: ItemDetail(service: widget.service), 
    );
  }
}
