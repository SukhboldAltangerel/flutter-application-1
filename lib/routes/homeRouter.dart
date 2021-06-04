import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/router.dart';

const home1 = '/home/home1';
const home2 = '/home/home2';
const home3 = '/home/home3';

class HomeRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print('${settings.name} - HomeRoute');
    switch (settings.name) {
      case home1:
        return MaterialPageRoute(
          builder: (_) => Container(
            child: Text('home 1'),
          ),
        );
      case home2:
        return MaterialPageRoute(
          builder: (_) => Container(
            child: Text('home 2'),
          ),
        );
      case home3:
        return MaterialPageRoute(
          builder: (_) => Container(
            child: Text('home 3'),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => NotFound(url: settings.name),
        );
    }
  }
}
