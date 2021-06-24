part of 'order_bloc.dart';
abstract class OrderState extends Equatable {
  const OrderState();
}
class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}
