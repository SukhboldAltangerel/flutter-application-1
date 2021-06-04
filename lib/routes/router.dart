import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/start_up.dart';

const startUpRoute = '/start-up';
const loginRoute = '/login';
const homeRoute = '/home';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    print('${settings.name} - AppRoute');
    switch (settings.name) {
      case startUpRoute:
        return MaterialPageRoute(builder: (_) => StartUp());
      case loginRoute:
        return MaterialPageRoute(builder: (_) => Login());
      case homeRoute:
        return MaterialPageRoute(builder: (_) => Home());
      default:
        return MaterialPageRoute(builder: (_) => NotFound(url: settings.name));
    }
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
