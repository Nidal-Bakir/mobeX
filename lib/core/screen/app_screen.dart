import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobox/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:mobox/features/categories/bloc/categories_bloc.dart';
import 'package:mobox/features/categories/presentation/screen/categories_tab.dart';
import 'package:mobox/features/home_feed/presentation/screen/home_tab.dart';
import 'package:mobox/features/order/presentation/bloc/order_bloc/order_bloc.dart';
import 'package:mobox/features/profile/presentation/screen/profile.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 4, vsync: this, initialIndex: 0);

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    // init the order bloc to listen to event from cart bloc
    context.read<OrderBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/orders');
                },
                child: Text('orders'))
          ],
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
                isScrollable: true,
                tabs: <Widget>[
                  Tab(text: 'HOME'),
                  Tab(text: 'CATEGORIES'),
                  Tab(text: 'NOTIFICATIONS'),
                  Tab(text: 'PROFILE'),
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
            Tab2(),
            Profile()
          ],
        ),
      ),
    );
  }
}

class Tab2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('rebuild Tab2');
    return Container(
      child: Text("Tab 2"),
    );
  }
}
