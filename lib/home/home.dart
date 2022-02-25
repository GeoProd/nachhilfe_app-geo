import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nachhilfe/screens/schulenUebersicht.dart';
import 'package:nachhilfe/services/auth.dart';

import '../screens/authenticate/sign_in.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //final AuthService _auth = AuthService();
  // bool showSignIn = true;
  // void toggleView() {
  //   //! gives us the opposite
  //   //If it is true it will make it true and viceversa
  //   setState(() => showSignIn = !showSignIn);
  // }

  @override
  void initState(){
    super.initState();

    // FirebaseAuth.instance.authStateChanges().listen((firebaseuser){
    //   if(firebaseuser == null){
    //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => SignIn(toggleView: toggleView,)), (route) => false);
    //   }else{
    //
    //   }
    // });

  }

  @override
  Widget build(BuildContext context) {
    return SchulenUebersicht();

  }
}
