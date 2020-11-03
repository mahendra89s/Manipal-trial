import 'package:flutter/material.dart';
import 'package:calmity/screens/authenticate/register.dart';
import 'package:calmity/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  final bool page;
  Authenticate({this.page});
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showLogin;

  void showScreen() {
    setState(() {
      showLogin = widget.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    showScreen();
    if (showLogin) {
      return SignIn();
    } else {
      return Register();
    }
  }
}
