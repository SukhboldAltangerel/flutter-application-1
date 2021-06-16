import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    //when maxCrossAxisExtent is 200,
    //width: 200 -> height: 100, width: 100 -> height: 100,
    var width = MediaQuery.of(context).size.width;
    double maxCrossAxisExtent = min(max(width, 120), 200);
    double childAspectRatio =
        maxCrossAxisExtent == 200 ? 2 : maxCrossAxisExtent / 120;

    return GridView.extent(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      maxCrossAxisExtent: maxCrossAxisExtent,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: childAspectRatio,
      children: [
        GridItem(
          icon: Icons.ac_unit,
          label: 'AC Unit',
          gradientColor: Colors.teal,
        ),
        GridItem(
          icon: Icons.accessibility_new_rounded,
          label: 'Accessibility',
          gradientColor: Colors.amber,
        ),
        GridItem(
          icon: Icons.calculate,
          label: 'Calculate',
          gradientColor: Colors.purple,
        ),
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem({
    Key? key,
    @required this.icon,
    @required this.label,
    @required this.gradientColor,
  }) : super(key: key);
  final icon;
  final label;
  final gradientColor;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: Container(
          constraints: BoxConstraints(
            minHeight: 100,
          ),
          decoration: BoxDecoration(
            // color: Colors.grey.shade100.withOpacity(0.5),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topCenter,
              colors: [
                gradientColor.shade800.withOpacity(0.7),
                gradientColor.shade300.withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
