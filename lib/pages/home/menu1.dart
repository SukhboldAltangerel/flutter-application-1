import 'package:flutter/material.dart';

class Menu1 extends StatefulWidget {
  const Menu1({Key? key}) : super(key: key);

  @override
  _Menu1State createState() => _Menu1State();
}

class _Menu1State extends State<Menu1> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MenuItem(icon: Icons.ac_unit, label: 'AC unit'),
      ],
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    @required this.icon,
    @required this.label,
  }) : super(key: key);
  final icon;
  final label;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
