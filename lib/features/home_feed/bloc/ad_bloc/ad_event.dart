part of 'ad_bloc.dart';

abstract class AdEvent extends Equatable {
  const AdEvent();
}
/// ReRequested the ad data from api
class AdReRequested extends AdEvent {
  @override
  List<Object?> get props => [];
}
/// Added as result of click on product to see more details about it.
class AdProductClicked extends AdEvent {
  final Product product;

  const AdProductClicked({required this.product});

  @override
  List<Object?> get props => [product];
}