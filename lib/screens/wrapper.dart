import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nachhilfe/models/user.dart';
import 'package:nachhilfe/screens/authenticate/authenticate.dart';
import 'package:nachhilfe/home/home.dart';
import 'package:provider/provider.dart';
import '../data.dart';
import '../services/auth.dart';
import 'authenticate/sign_in.dart';

class wrapper extends StatefulWidget {
  wrapper({Key? key}) : super(key: key);

  @override
  State<wrapper> createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    // final users = Provider.of<List<MyUser>?>(context);
    // print(users[0]); ///"The id for the first user in the list : " +

    final AuthService _auth = AuthService();
    final _formKey = GlobalKey<FormState>();

    final FirebaseAuth auth = FirebaseAuth.instance;

    Future<String?> inputData() async {
      final User? user = await auth.currentUser;
      final uid = user?.uid;
      print("The id is : " + uid.toString());
      userID = uid.toString();
      return uid;
      // here you write the codes to input the data into firestore
    }
    inputData();
    //
    //
    // if(inputData() == null){
    //   if (user == null) {
    //     return Authenticate();
    //   } else {
    //     return Home();
    //   }
    // }else{
    //   return Authenticate();
    // }
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }

  }
}

// return either Home or Authenticate widget
//If a user is signed in show Home if not show the authentication widget
// if (_formKey.currentState!.validate()) {
//   dynamic result =
//       _auth.signInWithEmailAndPassword(
//       email, password);
//   if (result == null) {
//     return Authenticate();
//   }else{
//     return Home();
//   }
// }else{
//   return Home();
// }