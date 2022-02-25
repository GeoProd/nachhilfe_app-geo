import 'package:flutter/material.dart';
import 'package:nachhilfe/screens/authenticate/register.dart';
import 'package:nachhilfe/screens/authenticate/sign_in.dart';
import 'package:nachhilfe/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  const Authenticate();

  @override
  _State createState() => _State();
}

class _State extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    //! gives us the opposite
    //If it is true it will make it true and viceversa
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    // if (showSignIn == true) {
      return SignIn(toggleView: toggleView);
    // }
      // return Register(toggleView: toggleView);
    // }
  }
}
