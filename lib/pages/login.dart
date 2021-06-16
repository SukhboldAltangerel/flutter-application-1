import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/homeRouter.dart';
import 'package:flutter_application_1/utils/baseUrl.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _errorMessage = '';

  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  bool _obscureText = true;

  double _emailWidth = 40.0;
  double _passwordWidth = 40.0;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 2000),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOutBack,
  );

  bool _showLogin = true;

  TextEditingController _urlController = TextEditingController();

  initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        _emailWidth = 340.0;
      });
    });

    Future.delayed(Duration(milliseconds: 600), () {
      setState(() {
        _passwordWidth = 340.0;
      });
    });

    _controller.forward();
  }

  void requestEmailFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_emailFocusNode);
    });
  }

  void requestPasswordFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_passwordFocusNode);
    });
  }

  void togglePasswordHide() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> handleLoginPress() async {
    if (_formKey.currentState!.validate()) {
      final res = await http.post(
        Uri.parse(baseUrl + 'users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _emailController.text,
          'password': _passwordController.text,
        }),
      );
      if (res.statusCode == 200) {
        Navigator.pushNamed(context, home1Route);
      } else {
        ResError resError = ResError.fromJson(jsonDecode(res.body));
        setState(() {
          _errorMessage = resError.error.message;
        });
      }
    } else {
      return;
    }
  }

  void handleSwitchSettings() {
    setState(() {
      _showLogin = !_showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorsLogin.background,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorsLogin.redDark,
                colorsLogin.redDarker,
                colorsLogin.redDark,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 40,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: 240,
                      ),
                      child: Image(
                        image: AssetImage('lib/assets/logo.png'),
                        width: double.infinity,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: Text(
                        'Macs accounting',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 900),
                layoutBuilder: (widget, list) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [widget!, ...list],
                      alignment: Alignment.center,
                    ),
                  ],
                ),
                transitionBuilder:
                    (Widget widget, Animation<double> animation) {
                  final rotateAnim =
                      Tween(begin: pi, end: 0.0).animate(animation);
                  return AnimatedBuilder(
                    animation: rotateAnim,
                    child: widget,
                    builder: (context, widget) {
                      final isUnder = (ValueKey(_showLogin) != widget!.key);
                      var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
                      tilt *= isUnder ? -1.0 : 1.0;
                      final value = min(rotateAnim.value, pi / 2);
                      return Transform(
                        transform: Matrix4.rotationY(value)
                          ..setEntry(3, 0, tilt),
                        child: widget,
                        alignment: Alignment.center,
                      );
                    },
                  );
                },
                switchInCurve: Curves.easeInOutCubic,
                switchOutCurve: Curves.easeInOutCubic.flipped,
                child: _showLogin
                    ? loginContainer(
                        ValueKey(true),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AnimatedContainer(
                                duration: Duration(milliseconds: 1200),
                                curve: Curves.easeInOutCubic,
                                margin: EdgeInsets.fromLTRB(20, 16, 20, 5),
                                width: _emailWidth,
                                constraints: BoxConstraints(
                                  maxWidth: 340,
                                ),
                                child: TextFormField(
                                  focusNode: _emailFocusNode,
                                  decoration: loginInputDecoration('Имэйл хаяг',
                                      Icons.account_circle, _emailFocusNode),
                                  validator: validateEmail,
                                  controller: _emailController,
                                  style: loginInputTextStyle,
                                  onTap: requestEmailFocus,
                                  cursorColor: colorsLogin.focus,
                                  cursorHeight: 20,
                                  cursorRadius: Radius.circular(10),
                                  autofocus: false,
                                ),
                              ),
                              AnimatedContainer(
                                duration: Duration(milliseconds: 1200),
                                curve: Curves.easeInOutCubic,
                                margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                                width: _passwordWidth,
                                constraints: BoxConstraints(
                                  maxWidth: 340,
                                ),
                                child: TextFormField(
                                  focusNode: _passwordFocusNode,
                                  decoration: loginInputDecoration(
                                    'Нууц үг',
                                    Icons.lock,
                                    _passwordFocusNode,
                                    obscureText: _obscureText,
                                    togglePasswordHide: togglePasswordHide,
                                  ),
                                  validator: validatePassword,
                                  controller: _passwordController,
                                  obscureText: _obscureText,
                                  style: loginInputTextStyle,
                                  onTap: requestPasswordFocus,
                                  cursorColor: colorsLogin.focus,
                                  cursorHeight: 20,
                                  cursorRadius: Radius.circular(10),
                                  autofocus: false,
                                ),
                              ),
                              if (_errorMessage != '')
                                Text(
                                  _errorMessage,
                                  style: TextStyle(
                                    color: colorsLogin.error,
                                  ),
                                ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                                child: ScaleTransition(
                                  scale: _animation,
                                  child: ElevatedButton(
                                    autofocus: false,
                                    clipBehavior: Clip.none,
                                    child: Text('Нэвтрэх'),
                                    onPressed: handleLoginPress,
                                    style: elevatedButtonStyle,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 8, 20, 14),
                                child: ScaleTransition(
                                  scale: _animation,
                                  child: ElevatedButton(
                                    autofocus: false,
                                    clipBehavior: Clip.none,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('Тохиргоо '),
                                        Icon(
                                          Icons.settings,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                    onPressed: handleSwitchSettings,
                                    style: ElevatedButton.styleFrom(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 14, 18, 14),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      primary: colorsLogin.focus,
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        height: 0.96,
                                      ),
                                      elevation: 4,
                                      shadowColor: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : loginContainer(
                        ValueKey(false),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(24, 16, 20, 5),
                              child: Text('Серверийн тохиргоо:'),
                              alignment: Alignment.centerLeft,
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(16, 8, 16, 5),
                              child: TextFormField(
                                decoration: urlInputDecoration,
                                controller: _urlController,
                                style: loginInputTextStyle,
                                cursorColor: colorsLogin.focus,
                                cursorHeight: 20,
                                cursorRadius: Radius.circular(10),
                                autofocus: false,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 8, 20, 14),
                              child: ElevatedButton(
                                autofocus: false,
                                clipBehavior: Clip.none,
                                child: Text('Хадгалах'),
                                onPressed: handleSwitchSettings,
                                style: elevatedButtonStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              Positioned(
                bottom: 10,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2021 Infosystems LLC',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _controller.dispose();
  }
}

String? validateEmail(value) {
  if (value.isEmpty) {
    return 'Имайл хаяг оруулна уу';
  } else
    return null;
}

String? validatePassword(value) {
  if (value.isEmpty) {
    return 'Нууц үгээ оруулна уу';
  } else
    return null;
}

class Error {
  int statusCode;
  String message;

  Error(this.statusCode, this.message);

  factory Error.fromJson(dynamic json) {
    return Error(json['statusCode'] as int, json['message'] as String);
  }
}

class ResError {
  bool success;
  Error error;

  ResError(this.success, this.error);

  factory ResError.fromJson(dynamic json) {
    return ResError(json['success'] as bool, Error.fromJson(json['error']));
  }
}

Container loginContainer(key, child) {
  return Container(
    key: key,
    constraints: BoxConstraints(
      maxWidth: 400,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(10),
      ),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 4),
          blurRadius: 4,
          spreadRadius: 2,
          color: Colors.black.withOpacity(0.3),
        ),
      ],
    ),
    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
    child: child,
  );
}

InputDecoration loginInputDecoration(label, icon, focusNode,
    {obscureText = 'none', togglePasswordHide}) {
  return InputDecoration(
    labelText: label,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      borderSide: BorderSide(
        color: colorsLogin.focus,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      borderSide: BorderSide(
        color: colorsLogin.error,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      borderSide: BorderSide(
        color: colorsLogin.error,
      ),
    ),
    prefixIcon: Icon(
      icon,
      color: focusNode.hasFocus ? colorsLogin.focus : colorsLogin.label,
      size: 22,
    ),
    labelStyle: TextStyle(
      color: focusNode.hasFocus ? colorsLogin.focus : colorsLogin.label,
    ),
    filled: true,
    fillColor: colorsLogin.fill,
    hoverColor: colorsLogin.fill,
    focusColor: colorsLogin.focus,
    errorStyle: TextStyle(
      height: 0.5,
    ),
    isDense: true,
    contentPadding: EdgeInsets.fromLTRB(20, 8, 20, 8),
    suffixIcon: obscureText == 'none'
        ? null
        : InkWell(
            child: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: focusNode.hasFocus ? colorsLogin.focus : colorsLogin.label,
              size: 22,
            ),
            onTap: () {
              togglePasswordHide();
            },
          ),
  );
}

InputDecoration urlInputDecoration = InputDecoration(
  labelText: 'Server API base url',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(100)),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(100)),
    borderSide: BorderSide(
      color: colorsLogin.focus,
    ),
  ),
  filled: true,
  fillColor: colorsLogin.fill,
  hoverColor: colorsLogin.fill,
  focusColor: colorsLogin.focus,
  isDense: true,
  contentPadding: EdgeInsets.fromLTRB(20, 12, 20, 12),
);

TextStyle loginInputTextStyle = TextStyle(
  fontSize: 14,
  color: Colors.black87,
);

ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
  padding: EdgeInsets.symmetric(
    horizontal: 26,
    vertical: 14,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(100),
  ),
  primary: colorsLogin.focus,
  textStyle: TextStyle(
    color: Colors.white,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  ),
  elevation: 4,
  shadowColor: Colors.black,
);

class ColorsLogin {
  var background = Color.fromRGBO(5, 16, 58, 1);
  var redDarker = Color(0xff4f1212);
  var redDark = Color(0xff7F1D1D);
  var red = Color(0xffB91C1C);
  var focus = Colors.blue.shade900;
  var error = Colors.red;
  var label = Colors.grey.shade600;
  var fill = Colors.grey.shade200;
}

ColorsLogin colorsLogin = new ColorsLogin();
