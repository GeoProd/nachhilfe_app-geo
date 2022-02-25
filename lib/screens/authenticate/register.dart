// import 'package:flutter/material.dart';
// import 'package:nachhilfe/services/auth.dart';
// import 'package:nachhilfe/Shared/constants.dart';
// import 'package:nachhilfe/Shared/loading.dart';
//
// class Register extends StatefulWidget {
//   final Function toggleView;
//   Register({required this.toggleView});
//
//   @override
//   _RegisterState createState() => _RegisterState();
// }
//
// class _RegisterState extends State<Register> {
//   final AuthService _auth = AuthService();
//   final _formKey = GlobalKey<FormState>();
//   bool loading = false;
//
//   String email = "";
//   String password = "";
//   String error = "";
//   @override
//   Widget build(BuildContext context) {
//     return loading
//         ? Loading()
//         : Scaffold(
//             backgroundColor: Colors.blue.shade200,
//             appBar: AppBar(
//               backgroundColor: Colors.blue[400],
//               elevation: 0.0,
//               title: Text('Sign up in to LernO'),
//               actions: <Widget>[
//                 TextButton.icon(
//                   icon: Icon(Icons.person),
//                   label: Text("Sign up"),
//                   onPressed: () {
//                     // Reffers to the same widget itself
//                     widget.toggleView();
//                   },
//                 )
//               ],
//             ),
//             body: Container(
//               padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//               child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: <Widget>[
//                       SizedBox(height: 20.0),
//                       TextFormField(
//                         decoration:
//                             textInputDecoration.copyWith(hintText: 'Email'),
//                         validator: (val) =>
//                             val!.isEmpty ? 'Enter an Email' : null,
//                         onChanged: (val) {
//                           // We are taking the email state and we are setting equal to whatever the email value is
//                           setState(() => email = val);
//                         },
//                       ),
//                       SizedBox(height: 20.0),
//                       TextFormField(
//                         decoration:
//                             textInputDecoration.copyWith(hintText: 'Password'),
//                         obscureText: true,
//                         validator: (val) => val!.length < 6
//                             ? 'Enter a Password 6+ Chars long'
//                             : null,
//                         onChanged: (val) {
//                           setState(() => password = val);
//                         },
//                       ),
//                       SizedBox(height: 20.0),
//                       ElevatedButton(
//                         child: Text(
//                           'Sign up',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onPressed: () async {
//                           //If we recieve null that means that it is valid and it will give true back
//                           if (_formKey.currentState!.validate()) {
//                             setState(() => loading = true);
//                             dynamic result = await _auth
//                                 .registerWithEmailAndPassword(email, password);
//                             if (result == null) {
//                               setState(() {
//                                 error = "Please supply a valid Email";
//                                 loading = false;
//                               });
//                             }
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                             primary: Colors.blue,
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 10, vertical: 5),
//                             textStyle: TextStyle(
//                                 fontSize: 10, fontWeight: FontWeight.bold)),
//                       ),
//                       SizedBox(height: 20.0),
//                       Text(
//                         error,
//                         style: TextStyle(color: Colors.red, fontSize: 14.0),
//                       )
//                     ],
//                   )),
//             ),
//           );
//   }
// }
