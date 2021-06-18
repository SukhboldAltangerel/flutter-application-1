import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home/menu.dart';
import 'package:flutter_application_1/pages/home/menu1.dart';
import 'package:flutter_application_1/utils/functions.dart';

const home1Route = '/home/home1';
const home2Route = '/home/home2';
const home3Route = '/home/home3';

class HomeRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print('${settings.name} - HomeRoute');
    String? pathName = getPathName(settings.name, 1);
    late Widget page;

    switch (pathName) {
      case '/home1':
        page = Menu1();
        break;
      case '/home2':
        page = Container(
          alignment: Alignment.center,
          child: Text('home 2'),
        );
        break;
      case '/home3':
        page = Container(
          alignment: Alignment.center,
          child: Text('home 3'),
        );
        break;
      default:
        page = Container(
          alignment: Alignment.center,
          child: Text('${settings.name} homePage not found.'),
        );
        break;
    }

    return MaterialPageRoute<dynamic>(
      builder: (_) => page,
      settings: settings,
      maintainState: true,
    );
  }
}
