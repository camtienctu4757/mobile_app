// ManagePages/service_ManagePage.dart
import 'package:app/app.dart';
import 'package:app/ui/manageservice/bloc/manage_event.dart';
import 'package:app/ui/manageservice/bloc/manage_state.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'bloc/manage_bloc.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class ServiceManagePage extends StatefulWidget {
  const ServiceManagePage({super.key, required this.shopId});
  final String shopId;
  @override
  State<ServiceManagePage> createState() => _ServiceManagePageState();
}

class _ServiceManagePageState
    extends BasePageState<ServiceManagePage, ServiceManageBloc>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget buildPage(BuildContext context) {
    return BlocProvider(
      create: (_) => ServiceManageBloc(GetIt.I.get<GetImageUseCase>(),
          GetIt.I.get<GetServicesByShopUseCase>())
        ..add(ServiceManagePageInitiated(shop_id: widget.shopId)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Dịch vụ'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: 'Gần đây'),
              Tab(text: 'Sắp ra mắt'),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildServiceList(context, true),
            _buildServiceList(context, false),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigator.push(AppRouteInfo.addservice(widget.shopId));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildServiceList(BuildContext context, bool isRecent) {
    return BlocBuilder<ServiceManageBloc, ServiceManageState>(
      builder: (context, state) {
        List<ServiceItem> services = state.serviceList!;
        return ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            return Card(
              elevation: 2,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                // leading: Image.network(service.imageUrl,
                //     width: 80, height: 80, fit: BoxFit.cover),
                title: Text(
                  services[index].name,
                  style: AppTextStyles.s16Blackbold(),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppUtils.formatCurrency(service.price.toDouble())
                          .toString(),
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'thời gian thực hiện ${services[index].duration} phút'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    // Chỗ để thêm logic chỉnh sửa
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
