import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/core/bloc/store_bloc/store_bloc.dart';
import 'package:mobox/core/model/store_model.dart';
import 'package:mobox/core/utils/global_function.dart';
import 'package:mobox/core/widget/Product_list_widget.dart';
import 'package:mobox/core/widget/follow_choice_chip.dart';
import 'package:mobox/features/home_feed/presentation/widget/new_products_sliver_grid.dart';

class StoreScreen extends StatefulWidget {
  final Store? store;
  final String? ownerUserName;

  const StoreScreen({Key? key, this.store, this.ownerUserName})
      : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  late Store? store = widget.store;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        var bloc = GetIt.I.get<StoreBloc>();
        if (widget.store == null) {
          bloc.add(StoreUserNameLoaded(
              ownerUserName: widget.ownerUserName.toString()));
        } else {
          bloc.add(StoreLoaded(store: widget.store!));
        }
        return bloc;
      },
      child: Builder(
        builder: (context) => Scaffold(
          body: BlocBuilder<StoreBloc, StoreState>(
            buildWhen: (previous, current) =>
                current is StoreLoadingInProgress ||
                current is StoreLoadFailure ||
                current is StoreLoadSuccess ||
                current is StoreInitial,
            builder: (BuildContext context, state) {
              if (state is StoreLoadingInProgress || state is StoreInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is StoreLoadFailure) {
                return Text('error while loading store info!!');
              } else if (state is StoreLoadSuccess) {
                store = state.store;
              }

              return BlocProvider(
                create: (context) => GetIt.I.get<ProductBloc>(
                    param1: '/store/${store!.ownerUserName}/newProducts'),
                child: Builder(
                  builder: (builderContext) =>
                      NotificationListener<ScrollNotification>(
                    onNotification: (notification) => notificationListener(
                      notification: notification,
                      onNotify: () => builderContext
                          .read<ProductBloc>()
                          .add(ProductMoreDataLoaded()),
                    ),
                    child: CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          title: FittedBox(
                            child: Text(
                              store!.storeName,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          expandedHeight:
                              MediaQuery.of(context).size.height * 0.5,
                          pinned: true,
                          stretch: true,
                          flexibleSpace: FlexibleSpaceBar(
                            titlePadding: EdgeInsets.zero,
                            title: Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.only(right: 8, bottom: 8),
                                child: FollowChoiceChip(
                                  store: store!,
                                ),
                              ),
                            ),
                            background: Hero(
                              tag: store!.ownerUserName,
                              child: Image.asset(
                                store!.profileImage,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Text(
                                  store!.bio,
                                  maxLines: 4,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: BlocProvider(
                            create: (context) => GetIt.I.get<ProductBloc>(
                                param1:
                                    '/store/${store!.ownerUserName}/offers'),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: ProductList(
                                title: 'Offers from ${store!.storeName}',
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, top: 32, bottom: 16),
                            child: Text(
                              'New from ${store!.storeName}',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                        NewProductSliverGrid(),
                        SliverToBoxAdapter(
                          child: Builder(
                            builder: (context) =>
                                BlocBuilder<ProductBloc, ProductState>(
                              builder: (context, state) {
                                if (state is ProductMoreInProgress)
                                  return LinearProgressIndicator();
                                else if (state is ProductLoadFailure)
                                  return Center(
                                    child: TextButton(
                                      onPressed: () => context
                                          .read<ProductBloc>()
                                          .add(ProductLoadRetried()),
                                      child: Text('RETRY'),
                                      style: Theme.of(context)
                                          .textButtonTheme
                                          .style,
                                    ),
                                  );
                                return Container();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
