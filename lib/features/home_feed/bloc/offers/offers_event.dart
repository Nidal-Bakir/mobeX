part of 'offers_bloc.dart';

abstract class OffersEvent extends Equatable {
  const OffersEvent();
}

/// ReRequested the Offers data from api
class OffersReRequested extends OffersEvent {
  const OffersReRequested();

  @override
  List<Object?> get props => [];
}
/// Added as result of click on product to see more details about it.
class OffersProductClicked extends OffersEvent {
  final Product product;

  const OffersProductClicked({required this.product});

  @override
  List<Object?> get props => [product];
}