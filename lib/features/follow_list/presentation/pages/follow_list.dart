import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobox/core/utils/global_function.dart';
import 'package:mobox/core/widget/retry_button.dart';
import 'package:mobox/core/widget/sliver_store_grid.dart';
import 'package:mobox/features/follow_list/presentation/manager/follow_list_bloc.dart';

class FollowList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FollowListBloc>(
      create: (BuildContext context) => GetIt.I.get(),
      child: Builder(
        builder: (context) => Scaffold(
          body: NotificationListener<ScrollNotification>(
            onNotification: (notification) => notificationListener(
              notification: notification,
              onNotify: () => context
                  .read<FollowListBloc>()
                  .add(FollowListMoreDataLoaded()),
            ),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text('Your follow list'),
                ),
                BlocBuilder<FollowListBloc, FollowListState>(
                  buildWhen: (previous, current) =>
                      current is! FollowListLoadFailure,
                  builder: (context, state) {
                    if (state is FollowListNoData) {
                      return Center(
                        child: Text('not follow yet!'),
                      );
                    } else if (state is FollowListLoadSuccess) {
                      return SliverStoresGrid(
                        storeList: state.followList,
                      );
                    } else if (state is FollowListInProgress) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    throw 'unexpected state from follow bloc: $state';
                  },
                ),
                BlocBuilder<FollowListBloc, FollowListState>(
                  buildWhen: (previous, current) =>
                      current is FollowListLoadFailure ||
                      previous is FollowListLoadFailure,
                  builder: (context, state) {
                    if (state is FollowListLoadFailure) {
                      return SliverToBoxAdapter(
                        child: Center(
                          child: RetryTextButton(
                            onClickCallback: () => context
                                .read<FollowListBloc>()
                                .add(FollowListLoadRetried()),
                          ),
                        ),
                      );
                    }
                    return Container();
                  },
                )
                // SliverStoresGrid(storeList: )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
