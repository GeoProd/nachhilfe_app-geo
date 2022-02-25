import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nachhilfe/models/Names.dart';
import 'package:nachhilfe/models/lehrer.dart';
import 'package:nachhilfe/models/schule.dart';
import 'package:nachhilfe/models/schueler.dart';
import 'package:nachhilfe/models/termine.dart';
import 'package:nachhilfe/models/Names.dart';
import 'package:nachhilfe/screens/terminUebersicht.dart';
import 'package:provider/provider.dart';

class DatabaseService {
  //final String uid;
  DatabaseService();

  //Collection reference
  final CollectionReference SchuleCollection =
      FirebaseFirestore.instance.collection('Schule');



  //Schule

  List<Schule> _schuleList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Schule(
        id: doc.id,
        ort: doc.get('ort') ?? '',
      );
    }).toList();
  }

  // Snapshot of the firestore collection at that moment when something changes
  Stream<List<Schule>> get dataSchule {
    //Return a stream
    return SchuleCollection.snapshots().map(_schuleList);
  }

  Future addSchule(String ort) async {
    // Call the user's CollectionReference to add a new user
    return SchuleCollection.add({
      'ort': ort,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }


  ///Schueler

  List<Schueler> _schuelerList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Schueler(
        id: doc.id,
        vorname: doc.get('vorname') ?? '',
        nachname: doc.get('nachname') ?? '',
        nummer: doc.get('nummer') ?? '',
        fach: doc.get('fach') ?? '',
        termin: doc.get('termin') ?? '',
        klasse: doc.get('klasse') ?? '',
      );
    }).toList();
  }

  Stream<List<Schueler>> dataSchueler(String schuleID) {
    //Return a stream
    return SchuleCollection.doc(schuleID).collection('Schueler').snapshots().map(_schuelerList);
  }

  Future addSchueler(String schuleID, String vorname, String nachname, String nummer, String fach, String termin, String klasse) async {
    // Call the user's CollectionReference to add a new user
    return SchuleCollection.doc(schuleID).collection('Schueler').add({
      'vorname': vorname,
      'nachname': nachname,
      'nummer': nummer,
      'fach': fach,
      'termin': termin,
      'klasse': klasse
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }


///Lehrer

  List<Lehrer> _lehrerList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Lehrer(
        id: doc.id,
        name: doc.get('name') ?? '',
      );
    }).toList();
  }

  // Snapshot of the firestore collection at that moment when something changes
  Stream<List<Lehrer>> dataLehrer (String schuleID) {
    //Return a stream
    return SchuleCollection.doc(schuleID).collection('Lehrer').snapshots().map(_lehrerList);
  }

  Future addLehrer(String rolle) async {
    // Call the user's CollectionReference to add a new user
    return SchuleCollection.add({
      'rolle': rolle,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  List<Termine> _termine(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Termine(
          id: doc.id,
          fach: doc.get('fach') ?? '',
          thema: doc.get('thema') ?? '',
          bemerkung: doc.get('bemerkung') ?? '',
          datum: doc.get('uhrzeit'),
          picture: doc.get('picture') ?? '',
          lehrerID: doc.get('lehrerID') ?? '',
          lehrer: doc.get('lehrer') ?? '');
    }).toList();
  }

  // Snapshot of the firestore collection at that moment when something changes
  Stream<List<Termine>> dataTermine(String schuleID, String schuelerID) {
    //Return a stream
    return SchuleCollection.doc(schuleID).collection('Schueler').doc(schuelerID).collection('Termine').snapshots().map(_termine);
  // Stream<List<Termine>> get dataTermine{
  //      //Return a stream
  //      return TermineCollection.snapshots().map(_termine);
  }
  //databaseReference.collection('Schueler').document( unique id).collection('Termine').document().setData();

  Future addTermin(String schuleID, String schuelerID, String fach, String thema, String bemerkung, Timestamp uhrzeit, String picture, String lehrerID, String lehrer) async {
    // Call the user's CollectionReference to add a new user
    return SchuleCollection.doc(schuleID).collection('Schueler').doc(schuelerID).collection('Termine')
        .add({
          'fach': fach,
          'thema': thema,
          'bemerkung': bemerkung,
          'uhrzeit': uhrzeit,
          'picture': picture,
          'lehrerID': lehrerID,
      'lehrer': lehrer,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  // List<Names> _searchNames(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return Names(
  //       vorname: doc.get('vorname') ?? '',
  //     );
  //   }).toList();
  // }
  //
  // Stream<List<Names>> get dataNames {
  //   //Return a stream
  //   return SchuleCollection.snapshots().map(_searchNames);
  // }

}

//const listSchueler = Provider.of<List<Schueler>?>;