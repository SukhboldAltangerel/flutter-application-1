import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/homeRouter.dart';
import 'package:flutter_application_1/utils/baseUrl.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();
  bool _obscureText = true;
  late AnimationController _controller;
  late Animation _length;

  initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2))
          ..addListener(() {
            print(_length.value);
          });

    final CurvedAnimation curve =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _length = Tween(begin: 40.0, end: 340.0).animate(curve);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red.shade900, Colors.blue.shade900],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
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
                      margin: EdgeInsets.only(top: 30),
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
                flex: 1,
              ),
              Container(
                constraints: BoxConstraints(maxWidth: 400),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 30, 20, 5),
                        width: _length.value,
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
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
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
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(20, 20, 20, 30),
                        child: ElevatedButton(
                          autofocus: false,
                          clipBehavior: Clip.none,
                          child: Text('НЭВТРЭХ'),
                          onPressed: handleLoginPress,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 16,
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
                          ),
                        ),
                      ),
                      if (_errorMessage != '')
                        Text(
                          _errorMessage,
                          style: TextStyle(
                            color: colorsLogin.error,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    'Copyright © 2021 Infosystems LLC',
                    style: TextStyle(
                      color: Colors.white,
                      height: 4,
                    ),
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}

String? validateEmail(value) {
  if (value.isEmpty) {
    return 'Имайл хаяг оруулна уу.';
  } else
    return null;
}

String? validatePassword(value) {
  if (value.isEmpty) {
    return 'Нууц үгээ оруулна уу.';
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
      size: 24,
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
              size: 24,
            ),
            onTap: () {
              togglePasswordHide();
            },
          ),
  );
}

TextStyle loginInputTextStyle = TextStyle(
  fontSize: 14,
  color: Colors.black87,
);

class ColorsLogin {
  var focus = Colors.blue.shade800;
  var error = Colors.red;
  var label = Colors.grey.shade600;
  var fill = Colors.grey.shade200;
}

ColorsLogin colorsLogin = new ColorsLogin();
