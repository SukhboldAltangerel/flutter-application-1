import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/start_up.dart';
import 'package:flutter_application_1/utils/functions.dart';

const startUpRoute = '/start-up';
const loginRoute = '/login';
const homeRoute = '/home';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print('${settings.name} - AppRoute');
    String? pathName = getPathName(settings.name, 0);
    late Widget page;

    switch (pathName) {
      case startUpRoute:
        page = StartUp();
        break;
      case loginRoute:
        page = Login();
        break;
      case homeRoute:
        page = Home();
        break;
      default:
        page = NotFound(url: settings.name);
        break;
    }

    return MaterialPageRoute(
      builder: (_) => page,
      settings: settings,
      maintainState: true,
    );
  }
}

class NotFound extends StatelessWidget {
  NotFound({@required this.url});
  final url;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text('$url not found 404.'),
    );
  }
}
