import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobox/core/utils/global_function.dart';
import 'package:mobox/core/widget/retry_button.dart';
import 'package:mobox/core/widget/sliver_store_grid.dart';
import 'package:mobox/features/search/bloc/store_search_bloc.dart';
import 'package:mobox/features/search/util/search_value_state_provider.dart';

class StoreSearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoreSearchBloc, StoreSearchState>(
      builder: (context, state) {
        final _searchStateProv = context.read<SearchValueStateProvider>();

        if (state is StoreSearchLoadSuccess) {
          return NotificationListener<ScrollNotification>(
              onNotification: (notification) => notificationListener(
                    notification: notification,
                    onNotify: () => context.read<StoreSearchBloc>().add(
                          StoreSearchMoreDataLoaded(
                            storeName: _searchStateProv.getSearchTerms(),
                          ),
                        ),
                  ),
              child: CustomScrollView(
                slivers: [
                  SliverStoresGrid(
                    storeList: state.storeList,
                  ),
                ],
              ));
        } else if (state is StoreSearchLoadFailure) {
          return CustomScrollView(
            slivers: [
              SliverStoresGrid(
                storeList: state.storeList,
              ),
              SliverToBoxAdapter(
                child: RetryTextButton(
                  onClickCallback: () => context.read<StoreSearchBloc>().add(
                        StoreSearchLoadRetried(
                          storeName: _searchStateProv.getSearchTerms(),
                        ),
                      ),
                ),
              )
            ],
          );
        } else if (state is StoreSearchLoadNoData) {
          return Center(
            child: Text(
              'Your search return nothing!!',
              style: Theme.of(context).textTheme.headline5,
            ),
          );
        } else if (state is StoreSearchMoreDataInProgress) {
          return CustomScrollView(
            slivers: [
              SliverStoresGrid(
                storeList: state.storeList,
              ),
              SliverToBoxAdapter(
                child: LinearProgressIndicator(),
              ),
            ],
          );
        } else if (state is StoreSearchInitial) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(
                'assets/images/search1.svg',
                width: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text(
                  'Enter few words to search MobeX ...',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
