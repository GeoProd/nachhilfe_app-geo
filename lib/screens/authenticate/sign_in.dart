import 'package:flutter/material.dart';
import 'package:nachhilfe/services/auth.dart';
import 'package:nachhilfe/Shared/loading.dart';

import '../../data.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //Whenever loading is true i'm gonna show the loading widget
  bool loading = false;

  //text field state
  //String email = "";
  //String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                  //padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Form(
                      key: _formKey,
                      child: Column(children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                                height: 400,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/Back.jpg'),
                                        fit: BoxFit.fill)),
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                        top: 100,
                                        left: 10,
                                        width: 400,
                                        height: 300,
                                        child: Container(
                                            child: Image.asset(
                                                'assets/images/Lo.png',
                                                fit: BoxFit.fill)
                                            )),
                                    Positioned(
                                        left: 150,
                                        width: 80,
                                        height: 150,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/light-2.png'))),
                                        )),
                                  ],
                                ))
                          ],
                        ),
                        SizedBox(height: 60.0),
                        Container(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200),
                                        top: BorderSide(
                                            color: Colors.grey.shade200),
                                        right: BorderSide(
                                            color: Colors.grey.shade200),
                                        left: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                  validator: (val) =>
                                      val!.isEmpty ? 'Enter an Email' : null,
                                  onChanged: (val) {
                                    // We are taking the email state and we are setting equal to whatever the email value is
                                    setState(() => email = val);
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade200),
                                        top: BorderSide(
                                            color: Colors.grey.shade200),
                                        right: BorderSide(
                                            color: Colors.grey.shade200),
                                        left: BorderSide(
                                            color: Colors.grey.shade200))),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle:
                                          TextStyle(color: Colors.grey[400])),
                                  obscureText: true,
                                  validator: (val) => val!.length < 6
                                      ? 'Enter a Password 6+ Chars long'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                ),
                              ),
                              SizedBox(height: 20.0),
                              InkWell(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => loading = true);
                                    dynamic result =
                                        await _auth.signInWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        error = "Unable to sign in";
                                        loading = false;
                                      });
                                    }
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                    color: cBlue,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        )
                      ]))),
            ));
  }
}
