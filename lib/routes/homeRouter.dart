import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/router.dart';

const home1Route = '/home/home1';
const home2Route = '/home/home2';
const home3Route = '/home/home3';

class HomeRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print('${settings.name} - HomeRoute');
    switch (settings.name) {
      case home1Route:
        return MaterialPageRoute(
          builder: (_) => Container(
            child: Text('home 1'),
          ),
        );
      case home2Route:
        return MaterialPageRoute(
          builder: (_) => Container(
            child: Text('home 2'),
          ),
        );
      case home3Route:
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
