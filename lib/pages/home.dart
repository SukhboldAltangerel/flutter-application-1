import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/routes/homeRouter.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  // static GlobalKey<NavigatorState> _homeNavKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          backgroundColor: Colors.blue.withOpacity(0),
          elevation: 0,
          actionsIconTheme: IconThemeData(
            color: colorsLogin.focus,
          ),
        ),
      ),
      endDrawer: HomeDrawer(),
      body: Navigator(
        // key: _homeNavKey,
        onGenerateRoute: HomeRouter.generateRoute,
        initialRoute: home1Route,
      ),
    );
  }
}

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

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
