import 'package:flutter/material.dart';
import 'package:mobox/presentation/widget/home_tab.dart';

class AppScreen extends StatefulWidget {
  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 4, vsync: this, initialIndex: 0);

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
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
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart_rounded),
                  onPressed: () {},
                )
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
            Tab1(),
            Tab2(),
            Text("Tab 4"),
          ],
        ),
      ),
    );
  }
}
class Tab1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('rebuild Tab1');
    return Container(child: Text("Tab 1"),);
  }
}class Tab2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print('rebuild Tab2');
    return Container(child: Text("Tab 2"),);
  }
}

