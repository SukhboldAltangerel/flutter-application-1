import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/routes/router.dart';
import 'package:flutter_application_1/utils/baseUrl.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String errorMessage = '';

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
        Navigator.pushNamed(context, homeRoute);
      } else {
        var resBody = jsonDecode(res.body);
        setState(() {
          errorMessage = 'Алдаа гарлаа.';
        });
      }
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Имэйл хаяг',
                ),
                validator: validateEmail,
                controller: _emailController,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Нууц үг',
                ),
                validator: validatePassword,
                controller: _passwordController,
                obscureText: true,
              ),
            ),
            Container(
              height: 70,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: ElevatedButton(
                autofocus: false,
                clipBehavior: Clip.none,
                child: Text(
                  'Нэвтрэх',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onPressed: handleLoginPress,
              ),
            ),
            if (errorMessage != '')
              Text(
                errorMessage,
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
          ],
        ),
      ),
    );
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
