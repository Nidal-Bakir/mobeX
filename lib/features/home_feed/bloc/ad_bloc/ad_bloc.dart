import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobox/core/error/exception.dart';
import 'package:mobox/core/model/product_model.dart';
import 'package:mobox/features/home_feed/data/repository/home_repo.dart';

part 'ad_event.dart';

part 'ad_state.dart';

class AdBloc extends Bloc<AdEvent, AdState> {
  final HomeRepo homeRepo;

  AdBloc({required this.homeRepo}) : super(AdInProgress());

  @override
  Stream<AdState> mapEventToState(
    AdEvent event,
  ) async* {
    if (event is AdDataLoaded) {
      yield* _dataLoadedHandler();
    } else if (event is AdReRequested) {
      yield* _adRequestedHandler();
    }
  }

  Stream<AdState> _dataLoadedHandler() async* {
    yield* _loadData();
  }

  Stream<AdState> _adRequestedHandler() async* {
    yield AdInProgress();
    yield* _loadData();
  }

  Stream<AdState> _loadData() async* {
    try {
      var adList = await homeRepo.getAdList() ;
      if (adList.isEmpty)
        yield AdNoData();
      else
        yield AdLoadSuccess(adList: adList);
    } on ConnectionExceptionWithData catch (e) {
      yield AdLoadFailure(adList: e.data as List<Product>);
    }
  }
}
