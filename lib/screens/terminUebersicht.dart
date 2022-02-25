import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nachhilfe/models/schueler.dart';
import 'package:nachhilfe/models/termine.dart';
import 'package:nachhilfe/screens/schuelerInformation.dart';
import 'package:nachhilfe/screens/schulenUebersicht.dart';
import 'package:provider/provider.dart';
import '../utils.dart';
import '/data.dart';
import 'package:signature/signature.dart';
import 'package:nachhilfe/services/database.dart';
import 'package:intl/intl.dart';

import 'eintragen.dart';

class TerminUebersicht extends StatefulWidget {
  final String id;
  final Schueler schueler;

  const TerminUebersicht({Key? key, required this.id, required this.schueler})
      : super(key: key);

  @override
  _schuelerState createState() => _schuelerState(id, schueler);
}

//TextEditingController _searchController = TextEditingController();
class _schuelerState extends State<TerminUebersicht> {
  String id;
  Schueler schueler;

  _schuelerState(this.id, this.schueler);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Termine>?>.value(
        initialData: null,
        // We are using this stream to wrap the rest of the widget
        value: DatabaseService().dataTermine(aktSchule, id),
        child: Scaffold(
          body: TerminListe(id: id, schueler: schueler),
        ));
  }
}

class TerminListe extends StatefulWidget {
  final String id;
  final Schueler schueler;

  TerminListe({required this.id, required this.schueler});

  @override
  _TerminListeState createState() => _TerminListeState(id, schueler);
}

class _TerminListeState extends State<TerminListe> {
  String id;
  Schueler schueler;

  _TerminListeState(this.id, this.schueler);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<List<Termine>?>(context);
    data?.sort((a, b) => b.datum.compareTo(a.datum));
    List fachAnzahl = [0, 0, 0, 0];
    data?.forEach((i) {
      if (i.fach.contains("Mathe") || i.fach.contains("mathe")) {
        fachAnzahl[0] += 1;
      } else if (i.fach.contains("Deutsch") || i.fach.contains("deutsch")) {
        fachAnzahl[1] += 1;
      } else if (i.fach.contains("Englisch") || i.fach.contains("englisch")) {
        fachAnzahl[2] += 1;
      } else {
        fachAnzahl[3] += 1;
      }
      //_searchResult.add(i);
    });

    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
            title: Text(schueler.vorname + " " + schueler.nachname),
            backgroundColor: cBlue,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SchuelerInfo(schueler: schueler)),
                        )
                      },
                  icon: Icon(Icons.info_outline)),
              IconButton(
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Eintragen(id: id), //terminId: null
                            ))
                      },
                  icon: Icon(Icons.add))
            ]),
        body: Column(
          children: [
            Container(
              child: Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, right: 10.0, bottom: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: cMathe),
                              child: Center(
                                  child: Text(
                                "Mathe: " + fachAnzahl[0].toString(),
                                style: Termin2,
                              )),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: cDeutsch),
                              child: Center(
                                  child: Text(
                                "Deutsch: " + fachAnzahl[1].toString(),
                                style: Termin2,
                              )),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: cEnglisch),
                              child: Center(
                                  child: Text(
                                "Englisch: " + fachAnzahl[2].toString(),
                                style: Termin2,
                              )),
                            ),
                          )),
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: cAndere),
                              child: Center(
                                  child: Text(
                                "Andere: " + fachAnzahl[3].toString(),
                                style: Termin2,
                              )),
                            ),
                          )),
                    ],
                  ),
                );
              }),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data?.length != null ? data?.length : 0,
                itemBuilder: (context, index) {
                  return termin_detail(data, index);
                },
              ),
            ),
          ],
        ));
  }

  termin_detail(terminListe, int i) {
    return Container(
        decoration: BoxDecoration(
            color: terminListe[i].fach.contains("Mathe") ||
                    terminListe[i].fach.contains("mathe")
                ? cBlue
                : terminListe[i].fach.contains("Deutsch") ||
                        terminListe[i].fach.contains("deutsch")
                    ? Color(0xffC24F57)
                    : terminListe[i].fach.contains("Englisch") ||
                            terminListe[i].fach.contains("englisch")
                        ? Colors.green.shade400
                        : cAndere,
            border: Border.all(color: cBlue),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 10),
        child: new GestureDetector(
          child: InkWell(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Table(columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(6),
              },
                  //mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                  children: <TableRow>[
                    TableRow( children: <Widget>[
                      Container(padding: EdgeInsets.symmetric (vertical: 3),child: Text('Datum:',
              style: Termin)),
                      Container(padding: EdgeInsets.symmetric (vertical: 3),
                        child: Text(
                            DateFormat('dd.MM.yyyy')
                                .format(terminListe[i].datum.toDate())
                                .toString(),
                            style: Termin2),
                      )
                    ]),
                    TableRow(children: <Widget>[
                      Container(padding: EdgeInsets.symmetric (vertical: 3),child: Text('Fach:',
                          style: Termin)),
                      Container(padding: EdgeInsets.symmetric (vertical: 3),
                        child: Text(
                            terminListe[i].fach,
                            style: Termin2),
                      )
                    ]),
                    TableRow(children: <Widget>[
                      Container(padding: EdgeInsets.symmetric (vertical: 2),child: Text('Thema:',
                          style: Termin)),
                      Container(padding: EdgeInsets.symmetric (vertical: 2),
                        child: Text(
                            terminListe[i].thema,
                            style: Termin2),
                      )
                    ]),
                    TableRow(children: <Widget>[
                      Container(padding: EdgeInsets.symmetric (vertical: 2),child: Text('Lehrer:',
                          style: Termin)),
                      Container(padding: EdgeInsets.symmetric (vertical: 2),
                        child: Text(
                            terminListe[i].lehrer,
                            style: Termin2),
                      )
                    ]),
                    TableRow(children: <Widget>[
                      Container(padding: EdgeInsets.symmetric (vertical: 2),child: Text('Bemerkung:',
                          style: Termin)),
                      Container(padding: EdgeInsets.symmetric (vertical: 2),
                        child: Text(
                            terminListe[i].bemerkung,
                            style: Termin2),
                      )
                    ]),
                  ]),

            ),
          ),
        ));
  }
}
