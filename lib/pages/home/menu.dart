import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    double maxCrossAxisExtent = min(max(width, 120), 160);
    double childAspectRatio =
        maxCrossAxisExtent == 160 ? 1.2 : maxCrossAxisExtent / 120;

    return GridView.extent(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      maxCrossAxisExtent: maxCrossAxisExtent,
      mainAxisSpacing: 20,
      crossAxisSpacing: 24,
      childAspectRatio: childAspectRatio,
      children: [
        GridItem(
          icon: Icons.ac_unit_outlined,
          label: 'AC Unit',
        ),
        GridItem(
          icon: Icons.accessibility_new_outlined,
          label: 'Accessibility',
        ),
        GridItem(
          icon: Icons.calculate_outlined,
          label: 'Calculate',
        ),
      ],
    );
  }
}

class GridItem extends StatefulWidget {
  const GridItem({
    Key? key,
    @required this.icon,
    @required this.label,
  }) : super(key: key);

  final icon;
  final label;

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem>
    with SingleTickerProviderStateMixin {
  bool _tapped = false;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 150),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );
  late Animation<double> _scale;

  initState() {
    super.initState();
    _scale = Tween<double>(begin: 1, end: 0.9).animate(_animation);
  }

  void handleTapDown(TapDownDetails details) {
    // setState(() {
    //   _tapped = true;
    // });
    print('tapped');
    _controller.forward();
  }

  Future<void> handleTapUp(TapUpDetails details) async {
    // setState(() {
    //   _tapped = false;
    // });
    print('unTapped');
    await _controller.forward().orCancel;
    _controller.reverse().whenComplete(() => print('navigate to!'));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: handleTapDown,
      onTapUp: handleTapUp,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 6),
                blurRadius: 10,
                spreadRadius: 4,
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: LayoutBuilder(builder: (context, constraints) {
                var height = constraints.maxHeight;
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    // gradient: RadialGradient(
                    //   tileMode: TileMode.mirror,
                    //   radius: 0.7,
                    //   colors: [
                    //     colorsLogin.focus.withOpacity(0.1),
                    //     colorsLogin.focus.withOpacity(0.3)
                    //   ],
                    // ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.bottomCenter,
                        height: height * 0.55,
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorsLogin.focus,
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                colorsLogin.focus,
                                colorsLogin.focus.withOpacity(0.8)
                              ],
                            ),
                          ),
                          height: height * 0.35,
                          width: height * 0.35,
                          alignment: Alignment.center,
                          child: Icon(
                            widget.icon,
                            color: Colors.white,
                            size: height * 0.22,
                          ),
                        ),
                      ),
                      Container(
                        height: height * 0.45,
                        alignment: Alignment.center,
                        child: Text(
                          widget.label,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
