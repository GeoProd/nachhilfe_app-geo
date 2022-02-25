import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:nachhilfe/models/user.dart';
import 'package:nachhilfe/services/database.dart';

import '../data.dart';

class AuthService {
  //late Timer _authTimer;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create user obj based on firebaseUser
  MyUser? _userfromFirebase(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth change user stream
  //Everytime a user sign in or sign out we are going to get a response down the stream
  // map it into our user so when we listen to this stream that user object is what we gest back
  Stream<MyUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userfromFirebase(user!));
  }

  // Future reauthenticateUser(String email, String password) async {
  //   AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
  //    // Reauthenticate
  //   await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
  // }

  //Sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      myUser = result.user;
      return _userfromFirebase(myUser!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email and password
  // Future registerWithEmailAndPassword(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     User? user = result.user;
  //     // Create a documnent for the user with the uid
  //     //await DatabaseService(uid: user!.uid)
  //         //.updateUserData('George', 'Wuppertal');
  //     //return _userfromFirebase(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Future autoLogout async (
  // _expiryDate.difference()
  // //final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
  //     Timer(Duration(seconds: ));
  //     )
}
