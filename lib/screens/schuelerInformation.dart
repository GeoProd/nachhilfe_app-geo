import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data.dart';
import '../models/schueler.dart';
import '../services/database.dart';
import '../utils.dart';

class SchuelerInfo extends StatefulWidget {
  final Schueler schueler;
  const SchuelerInfo({Key? key, required this.schueler}) : super(key: key);

  @override
  State<SchuelerInfo> createState() => _SchuelerInfoState(schueler);
}

class _SchuelerInfoState extends State<SchuelerInfo> {
  Schueler schueler;
  _SchuelerInfoState(this.schueler);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Schueler>?>.value(
        initialData: null,
        // We are using this stream to wrap the rest of the widget
        value: DatabaseService().dataSchueler(aktSchule),
        child: Container(
            child: Info(schueler: schueler) //id:id
        )
    );
  }

}
class Info extends StatefulWidget {
  final Schueler schueler;
  const Info({Key? key, required this.schueler}) : super(key: key);

  @override
  _InfoState createState() => _InfoState(schueler);
}

class _InfoState extends State<Info> {
  Schueler schueler;
  _InfoState(this.schueler);
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<List<Schueler>?>(context);
    return   Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
            title: Text("Schülerinfo"),
            backgroundColor: cBlue,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  onPressed: () => Utils.openPhoneCall(phoneNumber: schueler.nummer),//launch("tel://2165165161"),//"),
                  icon: Icon(Icons.call)
              ),
              // PopupMenuButton(
              //   //onSelected: ,
              //   itemBuilder: (BuildContext context) {
              //     return {'Termine'}.map((String choice) {
              //       return PopupMenuItem(
              //         value: choice,
              //         child: Text(choice),
              //       );
              //     }).toList();
              //   },
              // ),
            ]),
        body: ListView(
            children: [termin_detail(schueler)]
        )

    );
  }
  termin_detail(schueler) {
    return Container(
        decoration: BoxDecoration(
            color: cBlue,
            border: Border.all(color: cBlue),
            borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        margin: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
        child: new GestureDetector(
          child: InkWell(
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Name:\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t',
                          style: Termin,
                          children: <TextSpan>[
                            TextSpan(text: schueler.vorname +" "+ schueler.nachname, style: Termin2),
                          ],
                        ),
                      ),//Text("Fach:\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t" +terminListe[i].fach),
                    ), Padding(
                      padding: EdgeInsets.all(4.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Klasse:\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t',
                          style: Termin,
                          children: <TextSpan>[
                            TextSpan(text: schueler.klasse , style: Termin2),
                          ],
                        ),
                      ),//Text("Fach:\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t" +terminListe[i].fach),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Telefonnummer:\t\t\t\t\t\t\t',
                          style: Termin,
                          children: <TextSpan>[
                            TextSpan(text: schueler.nummer, style: Termin2),
                          ],
                        ),
                      ),//Text("Fach:\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t" +terminListe[i].fach),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Fächer:\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t',
                          style: Termin,
                          children: <TextSpan>[
                            TextSpan(text: schueler.fach, style: Termin2),
                          ],

                        ),
                      ),//Text("Thema:\t\t\t\t\t\t\t\t\t\t\t\t\t" +terminListe[i].thema),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: RichText(
                        text: TextSpan(
                          text: 'Termine:\n',
                          style: Termin,
                          children: <TextSpan>[
                            TextSpan(text: schueler.termin, style: Termin2),
                          ],
                        ),
                      ),//Text("Bewertung:\t\t\t\t\t\t" +terminListe[i].bewertung),
                    ),
                  ]),
            ),
          ),
        ));
  }
}

