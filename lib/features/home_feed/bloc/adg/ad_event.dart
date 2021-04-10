part of 'ad_bloc.dart';

abstract class AdEvent extends Equatable {
  const AdEvent();
}

/// ReRequested the ad data from api
class AdReRequested extends AdEvent {
  @override
  List<Object?> get props => [];
}
/// Requested ad data from api
class AdDataLoaded extends AdEvent {
  @override
  List<Object?> get props => [];
}
