import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nachhilfe/screens/authenticate/sign_in.dart';
import 'package:nachhilfe/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nachhilfe/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //User ID holen
  // final FirebaseAuth auth = FirebaseAuth.instance;
  //
  // Future<String?> inputData() async {
  //   final User? user = await auth.currentUser;
  //   final uid = user?.uid;
  //   print("The id is : " + uid.toString());
  //   return uid;
  //   // here you write the codes to input the data into firestore
  // }

  @override
  Widget build(BuildContext context) {
    // bool showSignIn = true;
    // void toggleView() {
    //   //! gives us the opposite
    //   //If it is true it will make it true and viceversa
    //   setState(() => showSignIn = !showSignIn);
    // }

    //inputData();

    final AuthService _auth = AuthService();
    //.user from auth -- stream get user , we named it user
    // if(inputData() != null){
    //   return StreamProvider<MyUser?>.value(
    //       value: AuthService().user,
    //       initialData: null,
    //       catchError: (User, MyUser) => null,
    //       child: MaterialApp(
    //           debugShowCheckedModeBanner: false,
    //           home: wrapper()
    //       ));
    // }else{
    //   return SignIn(toggleView: toggleView);
    // }

    return StreamProvider<MyUser?>.value(
        value: AuthService().user,
        initialData: null,
        catchError: (User, MyUser) => null,
        child: MaterialApp(debugShowCheckedModeBanner: false, home: wrapper()));
  }
}
