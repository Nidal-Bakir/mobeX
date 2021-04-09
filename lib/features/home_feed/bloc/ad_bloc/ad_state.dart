part of 'ad_bloc.dart';

abstract class AdState extends Equatable {
  const AdState();
}

class AdInProgress extends AdState {
  @override
  List<Object> get props => [];
}

class AdLoadSuccess extends AdState {
  final  List<Product> adList;

  const AdLoadSuccess({required this.adList});

  @override
  List<Object?> get props => [adList];
}

/// Emit when error occur while fetch the data.
///
/// The [adList] member hold the cached data or (null) to indecent there is no cached data
class AdLoadFailure extends AdState {
  final List<Product> adList;

  const AdLoadFailure({required this.adList});

  @override
  List<Object?> get props => [adList];
}

class AdNoData extends AdState {
  @override
  List<Object?> get props => [];
}
