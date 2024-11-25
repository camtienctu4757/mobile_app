import 'package:equatable/equatable.dart';

abstract class RevenueEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMonthlyRevenue extends RevenueEvent {
  final int month;
  final int year;

  LoadMonthlyRevenue(this.month, this.year);

  @override
  List<Object?> get props => [month, year];
}
