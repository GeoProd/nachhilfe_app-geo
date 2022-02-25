import 'package:cloud_firestore/cloud_firestore.dart';

class Termine {
  final String id;
  final String fach;
  final String thema;
  final String bemerkung;
  final Timestamp datum;
  final String picture;
  final String lehrerID;
  final String lehrer;

  Termine({required this.id, required this.fach,required this.thema, required this.bemerkung, required this.datum, required this.picture, required this.lehrerID, required this.lehrer});
}
