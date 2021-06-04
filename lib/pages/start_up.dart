import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/router.dart';

class StartUp extends StatefulWidget {
  @override
  _StartUpState createState() => _StartUpState();
}

class _StartUpState extends State<StartUp> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    final CurvedAnimation curve =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _fade = Tween<double>(begin: 0, end: 1).animate(curve);
    _slide =
        Tween<Offset>(begin: Offset.zero, end: Offset(0, -0.5)).animate(curve);
    _controller.forward().whenCompleteOrCancel(() {
      Navigator.pushNamed(context, loginRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: Image(
              image: AssetImage('lib/assets/logo.png'),
            ),
          ),
        ),
      ),
      onTap: () {
        _controller.stop(canceled: true);
      },
    );
  }

  dispose() {
    super.dispose();
    _controller.dispose();
  }
}
