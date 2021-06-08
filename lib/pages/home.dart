import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/homeRouter.dart';
import 'package:flutter_application_1/routes/router.dart';

class Home extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My app'),
      ),
      endDrawer: HomeDrawer(),
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: HomeRouter.generateRoute,
        initialRoute: home1Route,
        observers: [],
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            title: Text('Item 1'),
            onTap: () {
              Navigator.pushNamed(context, home1Route);
            },
          ),
          ListTile(
            title: Text('Item 2'),
            onTap: () {
              Navigator.pushNamed(context, home2Route);
            },
          ),
          ListTile(
            title: Text('Item 3'),
            onTap: () {
              Navigator.pushNamed(context, home3Route);
            },
          ),
        ],
      ),
    );
  }
}
