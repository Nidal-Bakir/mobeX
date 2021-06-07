import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobox/core/auth/bloc/auth/auth_bloc.dart';
import 'package:mobox/core/bloc/product_bloc/product_bloc.dart';
import 'package:mobox/core/utils/global_function.dart';
import 'package:mobox/core/widget/Product_list_widget.dart';
import 'package:mobox/features/home_feed/presentation/widget/new_products_sliver_grid.dart';
import 'package:mobox/features/profile/presentation/widget/profile_info_table.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) => current is AuthLoadUserProfileSuccess,
      builder: (context, state) {
        var userProfile = (state as AuthLoadUserProfileSuccess).userProfile;
        var store = userProfile.userStore;
        if (store == null)
          return Container(); // TODO return mesage that hes is not have store and show his basic info he can edit tho!

        return BlocProvider<ProductBloc>(
          create: (context) => GetIt.I.get<ProductBloc>(
              param1: '/store/${userProfile.userName}/newProducts'),
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
                    automaticallyImplyLeading: false,
                    expandedHeight: MediaQuery.of(context).size.height * 0.5,
                    flexibleSpace: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                        var top = constraints.biggest.height;
                        var oldRange = (320.0 - 80.0);
                        var newRange = (1.0 - 0.0);
                        var newValue =
                            (((top - 80.0) * newRange) / oldRange) + 0.0;

                        return FlexibleSpaceBar(
                          titlePadding: EdgeInsets.zero,
                          title: Opacity(
                            opacity: newValue > 1.0 ? 1.0 : newValue,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 8.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed('/edit-profile',arguments: userProfile);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.edit,
                                    ),
                                  ),
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style
                                      ?.copyWith(
                                          padding: MaterialStateProperty.all(
                                            EdgeInsets.zero,
                                          ),
                                          backgroundColor:
                                              MaterialStateProperty.resolveWith(
                                                  (states) {
                                            if (states.any({
                                              MaterialState.pressed,
                                            }.contains)) return Colors.green;
                                            return Colors.grey.withAlpha(100);
                                          }),
                                          shape: MaterialStateProperty.all(
                                              CircleBorder())),
                                ),
                              ),
                            ),
                          ),
                          background: Image.asset(
                            userProfile.profileImage,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                store.storeName,
                                maxLines: 2,
                                style: Theme.of(context).textTheme.headline6,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Text(
                                store.bio,
                                maxLines: 4,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
                          ),
                          Divider(),
                          ProfileInfoTable(
                            userProfile: userProfile,
                          ),
                          Divider(),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: BlocProvider(
                      create: (context) => GetIt.I.get<ProductBloc>(
                          param1: '/store/${userProfile.userName}/offers'),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: ProductList(
                          title: 'Your Offers',
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 24.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'New product',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed('/product-manage');
                              },
                              child: Text('ADD'),
                              style: Theme.of(context).textButtonTheme.style,
                            ),
                          ],
                        )),
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
                                style: Theme.of(context).textButtonTheme.style,
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
    );
  }
}
