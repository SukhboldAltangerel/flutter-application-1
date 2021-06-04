import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My app'),
      ),
      endDrawer: HomeDrawer(),
      body: Text('home'),
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
          ),
          ListTile(
            title: Text('Item 2'),
          ),
          ListTile(
            title: Text('Item 3'),
          ),
          ListTile(
            title: Text('Item 4'),
          ),
          ListTile(
            title: Text('Item 5'),
          ),
        ],
      ),
    );
  }
}
