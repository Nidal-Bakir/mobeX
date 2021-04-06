part of 'offers_bloc.dart';

abstract class OffersState extends Equatable {
  const OffersState();
}

class OffersInProgress extends OffersState {
  @override
  List<Object> get props => [];
}
class OffersLoadSuccess extends OffersState {
  final List<Product>? offersList;

  const OffersLoadSuccess({this.offersList});

  @override
  List<Object?> get props => [offersList];
}

/// Emit when error occur while fetch the data.
///
/// The [offersList] member hold the cached data or (null) to indecent there is no cached data
class OffersLoadFailure extends OffersState {
  final List<Product>? offersList;

  const OffersLoadFailure({this.offersList});

  @override
  List<Object?> get props => [offersList];
}