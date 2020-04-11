import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit/auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment(0.0, 0.0),
          child: Column(
            children: [
              MaterialButton(
                onPressed: () => authService.googleSignIn(),
                color: Colors.white,
                textColor: Colors.black,
                child: Text('Login with Google'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
