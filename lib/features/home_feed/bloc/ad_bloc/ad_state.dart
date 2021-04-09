part of 'ad_bloc.dart';

abstract class AdState extends Equatable {
  const AdState();
}

class AdInProgress extends AdState {
  @override
  List<Object> get props => [];
}

class AdLoadSuccess extends AdState {
  final  Stream<Product> adStream;

  const AdLoadSuccess({required this.adStream});

  @override
  List<Object?> get props => [adStream];
}

/// Emit when error occur while fetch the data.
///
/// The [adList] member hold the cached data or (null) to indecent there is no cached data
class AdLoadFailure extends AdState {
  final Stream<Product> adStream;

  const AdLoadFailure({required this.adStream});

  @override
  List<Object?> get props => [adStream];
}

class AdNoData extends AdState {
  @override
  List<Object?> get props => [];
}
