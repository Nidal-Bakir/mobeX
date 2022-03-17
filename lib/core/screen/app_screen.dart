import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:mobox/core/auth/bloc/auth/auth_bloc.dart';
import 'package:mobox/core/model/user_profiel.dart';
import 'package:mobox/core/model/user_store.dart';
import 'package:mobox/core/utils/const_data.dart';
import 'package:mobox/features/categories/bloc/categories_bloc.dart';
import 'package:mobox/features/categories/presentation/screen/categories_tab.dart';
import 'package:mobox/features/home_feed/presentation/screen/home_tab.dart';
import 'package:mobox/features/profile/presentation/screen/profile.dart';

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
        length: _userStore == null ? 2 : 3, vsync: this, initialIndex: 0);

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
                      Divider(),
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
              ],
              bottom: TabBar(
                controller: _tabController,
                isScrollable: _userStore == null ? false : true,
                tabs: <Widget>[
                  Tab(text: 'HOME'),
                  Tab(text: 'CATEGORIES'),
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
            if (_userStore != null) Profile()
          ],
        ),
      ),
    );
  }
}
