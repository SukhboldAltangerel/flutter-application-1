import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      theme: ThemeData(primaryColor: Colors.amber),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: startUpRoute,
    );
  }
}
