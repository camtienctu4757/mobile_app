import 'package:flutter_bloc/flutter_bloc.dart';
import 'revenue_event.dart';
import 'revenue_state.dart';

class RevenueBloc extends Bloc<RevenueEvent, RevenueState> {
  RevenueBloc() : super(RevenueInitial()) {
    on<LoadMonthlyRevenue>((event, emit) async {
      emit(RevenueLoading());
      try {
        // Đây là dữ liệu giả lập cho biểu đồ (cần thay bằng dữ liệu thật từ server hoặc API)
        Map<String, double> pieChartData = {
          "Doanh thu dịch vụ": 40,
          "Doanh thu sản phẩm": 30,
          "Doanh thu khác": 20,
          "Giảm giá": 10,
        };
        List<double> barChartData = [500, 700, 800, 400, 650];

        await Future.delayed(Duration(seconds: 1)); // Mô phỏng độ trễ lấy dữ liệu

        emit(RevenueLoaded(pieChartData: pieChartData, barChartData: barChartData));
      } catch (e) {
        emit(RevenueError("Lỗi khi tải dữ liệu"));
      }
    });
  }
}
