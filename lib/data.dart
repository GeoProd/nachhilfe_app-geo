import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


final FirebaseFirestore firestore = FirebaseFirestore.instance;

final Color c = Colors.blue.shade300;
final Color cT = Colors.red.shade700;
final Color cBlue = Color(0xff3e96c0);
final Color cBlueBack = Color(0xff6bd0ff);
final Color cBlue2 = Colors.blue.shade50;

final Color cTextField = Colors.white60;
final Color cRand = Color(0xff195673);
final Color cButton = Colors.red.shade400;

final Color cMathe = cBlue;
final Color cDeutsch = Color(0xffC24F57);
final Color cEnglisch = Colors.green.shade400;
final Color cAndere = Color(0xffe58649);
final Color cBlack = Color(0xff393939);
final Color cSchulenBack = Color(0xff1c88b1);

final TextStyle Termin = TextStyle(fontWeight: FontWeight.bold,color:Colors.black87);
final TextStyle Termin2 = TextStyle(fontWeight: FontWeight.bold,color:Colors.white);

final BoxDecoration boxDecoration = BoxDecoration(
    color: cBlue,
    border: Border.all(color: cBlue),
    borderRadius: BorderRadius.all(Radius.circular(10)));

String aktSchule = '';

User? myUser;
String userID ="";
String email = "";
String password = "";

