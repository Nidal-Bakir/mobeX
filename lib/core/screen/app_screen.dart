import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobox/core/auth/bloc/auth/auth_bloc.dart';
import 'package:mobox/core/model/user_profiel.dart';
import 'package:mobox/core/model/user_store.dart';
import 'package:mobox/core/utils/const_data.dart';
import 'package:mobox/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:mobox/features/categories/bloc/categories_bloc.dart';
import 'package:mobox/features/categories/presentation/screen/categories_tab.dart';
import 'package:mobox/features/home_feed/presentation/screen/home_tab.dart';
import 'package:mobox/features/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:mobox/features/profile/presentation/screen/profile.dart';
import 'package:mobox/features/purchase_orders/presentation/manager/purchase_orders_bloc/purchase_orders_bloc.dart';
import 'package:mobox/features/purchase_orders/presentation/pages/purchase_orders_tab.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late UserStore? _userStore;
  late UserProfile _userProfile;

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    _userProfile =
        (context.read<AuthBloc>().state as AuthLoadUserProfileSuccess)
            .userProfile;
    _userStore = _userProfile.userStore;
    _tabController = TabController(
        length: _userStore == null ? 2 : 4, vsync: this, initialIndex: 0);

    // init the order bloc to listen to event from cart bloc
    context.read<OrderBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Drawer(
          child: Column(
            children: [
              /*
              * TODO :: uncomment this code
              *  Image.network(_userProfile.profileImage,fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                 ),
              * */
              Image.asset(
                _userProfile.profileImage,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all<TextStyle>(
                          TextStyle(fontWeight: FontWeight.w900)),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                    ),
                  ),
                  dividerTheme:
                      DividerThemeData(thickness: 1, color: Colors.black),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My padget',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            BlocBuilder<AuthBloc, AuthState>(
                              buildWhen: (previous, current) =>
                                  current is AuthLoadUserProfileSuccess,
                              builder: (context, state) {
                                if (state is AuthLoadUserProfileSuccess) {
                                  return Text(
                                    state.userProfile.balance.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  );
                                }
                                return Text(
                                  _userProfile.balance.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                      TextButton.icon(
                          icon: Icon(Icons.favorite_border_outlined),
                          onPressed: () {
                            if (_userProfile.token ==
                                ConstData.guestDummyToken) {
                              Navigator.of(context).pushNamed('/login');
                            } else {
                              Navigator.of(context).pushNamed('/following');
                            }
                          },
                          label: Text('Following')),
                      TextButton.icon(
                          icon: Icon(Icons.clear_all_outlined),
                          onPressed: () {
                            if (_userProfile.token ==
                                ConstData.guestDummyToken) {
                              Navigator.of(context).pushNamed('/login');
                            } else {
                              Navigator.of(context).pushNamed('/orders');
                            }
                          },
                          label: Text('My orders')),
                      if (_userStore == null)
                        TextButton.icon(
                          icon: Icon(Icons.store_outlined),
                          onPressed: () {
                            if (_userProfile.token ==
                                ConstData.guestDummyToken) {
                              Navigator.of(context).pushNamed('/login');
                            } else {
                              Navigator.of(context).pushNamed('/create-store');
                            }
                          },
                          label: Text('Create store'),
                        ),
                      TextButton.icon(
                        icon: Icon(Icons.extension_outlined),
                        onPressed: () {
                          if (_userStore == null) {
                            Navigator.of(context).pushNamed('/create-store');
                          } else {
                            Navigator.of(context).pushNamed('/product-manage');
                          }
                        },
                        label: Text('Add product'),
                      ),
                      Divider(),
                      TextButton.icon(
                        icon: Icon(Icons.textsms_outlined),
                        onPressed: () {},
                        label: Text('Contact us'),
                      ),
                      Divider(),
                      TextButton.icon(
                        icon: Icon(Icons.settings_outlined),
                        onPressed: () {},
                        label: Text('Settings'),
                      )
                    ],
                  ),
                ),
              ),
              // TODO : remove this test and the code
              // if (_userProfile.token != ConstData.guestDummyToken)
              //   Switch.adaptive(
              //       value: ForTestClass.isAStore,
              //       onChanged: (_) {
              //         ForTestClass.isAStore = !ForTestClass.isAStore;
              //       })
            ],
          ),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(
                'MobeX store',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontFamily: 'Leelawadee',
                ),
              ),
              floating: true,
              pinned: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/search');
                  },
                ),
                Stack(
                  children: [
                    Align(
                      child: IconButton(
                        icon: Icon(Icons.shopping_cart_rounded),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/cart');
                        },
                      ),
                    ),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartAddItemSuccess) {
                          return Positioned(
                            top: 5,
                            child: Container(
                              padding: EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).accentColor,
                              ),
                              child: Text(state.totalComputation.totalQuantity
                                  .toString()),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                isScrollable: _userStore == null ? false : true,
                tabs: <Widget>[
                  Tab(text: 'HOME'),
                  Tab(text: 'CATEGORIES'),
                  if (_userStore != null) Tab(text: 'PURCHASE ORDERS'),
                  if (_userStore != null) Tab(text: 'PROFILE'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            HomeTab(),
            BlocProvider<CategoriesBloc>(
              create: (context) => GetIt.I.get(),
              child: CategoriesTab(),
            ),
            if (_userStore != null)
              BlocProvider<PurchaseOrdersBloc>(
                create: (context) => GetIt.I.get(),
                child: PurchaseOrdersTab(),
              ),
            if (_userStore != null) Profile()
          ],
        ),
      ),
    );
  }
}
