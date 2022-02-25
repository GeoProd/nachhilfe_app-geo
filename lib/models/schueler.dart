import 'package:cloud_firestore/cloud_firestore.dart';

class Schueler {
   final String id;
   final String vorname;
   final String nachname;
   final String nummer;
   final String fach;
   final String klasse;
   final String termin;

 Schueler({required this.id, required this.vorname,required this.nachname, required this.nummer, required this.fach, required this.termin, required this.klasse});

   // Map<String, dynamic> toJson() => {
   //   'id': id,
   //   'vorname': vorname,
   //   'nachname': nachname,
   //   'nummer': nummer,
   //   'fach': fach,
   // };

  // Schueler.fromSnapshot(DocumentSnapshot snapshot, this.vorname,  this.nachname, this.id, this.nummer, this.fach) :
  //       id = snapshot['id'],
  //       vorname = snapshot['vorname'],
  //       nachname = snapshot['nachname'],
  //       nummer = snapshot['nummer'],
  //       fach = snapshot['fach'];

}

