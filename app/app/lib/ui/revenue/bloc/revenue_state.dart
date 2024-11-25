import 'package:equatable/equatable.dart';

abstract class RevenueState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RevenueInitial extends RevenueState {}

class RevenueLoading extends RevenueState {}

class RevenueLoaded extends RevenueState {
  final Map<String, double> pieChartData;
  final List<double> barChartData;

  RevenueLoaded({required this.pieChartData, required this.barChartData});

  @override
  List<Object?> get props => [pieChartData, barChartData];
}

class RevenueError extends RevenueState {
  final String message;

  RevenueError(this.message);

  @override
  List<Object?> get props => [message];
}
