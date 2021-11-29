import 'package:flutter/material.dart';
import 'package:to_do_list/screens/authenticate/register.dart';
import 'package:to_do_list/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool isOnSignIn = true;

  void switchView() {
    setState(() {
      isOnSignIn = !isOnSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isOnSignIn) {
      return SignIn(switchScreen: switchView);
    } else {
      return Register(switchScreen: switchView);
    }
  }
}
