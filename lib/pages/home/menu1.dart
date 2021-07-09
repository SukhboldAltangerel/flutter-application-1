import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/login.dart';

class Menu1 extends StatefulWidget {
  const Menu1({Key? key}) : super(key: key);

  @override
  _Menu1State createState() => _Menu1State();
}

class _Menu1State extends State<Menu1> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      children: [
        MenuCard(
          icon: Icons.ac_unit,
          label: 'AC Unit',
          child: Child1(),
        ),
        MenuCard(
          icon: Icons.umbrella,
          label: 'Umbrella',
          child: Child1(),
        ),
        MenuCard(
          icon: Icons.brightness_low_outlined,
          label: 'Brigthness',
          child: Child1(),
        ),
      ],
    );
  }
}

class MenuCard extends StatefulWidget {
  const MenuCard({
    Key? key,
    @required this.icon,
    @required this.label,
    @required this.child,
  }) : super(key: key);

  final icon;
  final label;
  final child;

  @override
  _MenuCardState createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard>
    with SingleTickerProviderStateMixin {
  bool _childDrawed = false;

  void handleToggleChildDraw() {
    setState(() {
      _childDrawed = !_childDrawed;
    });
    print('handleToggleChildDraw');
  }

  void handleCloseChild() {
    setState(() {
      _childDrawed = false;
    });
    print('handleCloseChild');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 4,
            spreadRadius: 4,
            color: Colors.black.withOpacity(0.1),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: handleToggleChildDraw,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(14),
                          child: Icon(
                            widget.icon,
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.label,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: colorsLogin.focus,
                                ),
                              ),
                              Text(
                                'Text 2',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey.shade700),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    var height = constraints.maxHeight;
                    return GestureDetector(
                      onTap: handleCloseChild,
                      child: Container(
                        height: height,
                        width: height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(menuStyle.borderRadius),
                          ),
                          color: Colors.red,
                        ),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // AnimatedBuilder(animation: animation, builder: builder),
        ],
      ),
    );
  }
}

class Child1 extends StatefulWidget {
  const Child1({Key? key}) : super(key: key);

  @override
  _Child1State createState() => _Child1State();
}

class _Child1State extends State<Child1> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Child text 1'),
        Text('Child text 2'),
        Text('Child text 3'),
        Text('Child text 4'),
      ],
    );
  }
}

class MenuStyle {
  var borderRadius = 8.0;
}

MenuStyle menuStyle = MenuStyle();
