import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/data.dart';
import 'package:nachhilfe/services/database.dart';

class schuelerErstellen extends StatefulWidget {
  const schuelerErstellen({Key? key}) : super(key: key);

  @override
  _schuelerErstellenState createState() => _schuelerErstellenState();
}

class _schuelerErstellenState extends State<schuelerErstellen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Schüler Erstellen'), backgroundColor: cBlue,),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/S5.jpg'),
                fit: BoxFit.cover
            )
        ),
        child: ListView(children: [
          schuelerErstellen(),
        ]),
      ),
    );
  }

  TextEditingController _eingabeVorname = TextEditingController();
  bool _validateVorname = false;
  TextEditingController _eingabeNachname = TextEditingController();
  bool _validateNachname = false;
  TextEditingController _eingabeNummer = TextEditingController();
  bool _validateNummer = false;
  TextEditingController _eingabeFach = TextEditingController();
  bool _validateFach = false;
  TextEditingController _eingabeTermin = TextEditingController();
  bool _validateTermin = false;
  TextEditingController _eingabeKlasse = TextEditingController();
  bool _validateKlasse = false;

  schuelerErstellen() {
    return Container(
        decoration: boxDecoration,
        margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(children: [
          Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextField(
            autofocus: true,
            //textCapitalization: TextCapitalization.characters,
            controller: _eingabeVorname,
            decoration: InputDecoration(
              errorText: _validateVorname ? 'Bitte eintragen' : null,
              filled: true,
              fillColor: cTextField,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              hintText: 'Vorname',

            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextField(
            controller: _eingabeNachname,
            decoration: InputDecoration(
              errorText: _validateNachname ? 'Bitte eintragen' : null,
              filled: true,
              fillColor: cTextField,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              hintText: 'Nachname',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextField(
            controller: _eingabeNummer,
            decoration: InputDecoration(
              errorText: _validateNummer ? 'Bitte eintragen' : null,
              filled: true,
              fillColor: cTextField,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              hintText: 'Nummer',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextField(
            controller: _eingabeKlasse,
            decoration: InputDecoration(
              errorText: _validateKlasse ? 'Bitte eintragen' : null,
              filled: true,
              fillColor: cTextField,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              hintText: 'Klasse',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextField(
            controller: _eingabeFach,
            decoration: InputDecoration(
              errorText: _validateFach ? 'Bitte eintragen' : null,
              filled: true,
              fillColor: cTextField,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              hintText: 'Fach',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TextField(
            controller: _eingabeTermin,
            decoration: InputDecoration(
              errorText: _validateTermin ? 'Bitte eintragen' : null,
              filled: true,
              fillColor: cTextField,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              hintText: 'Termin',
            ),
          ),
        ),
        SizedBox(height: 20.0),
        ElevatedButton(
        style: ElevatedButton.styleFrom(
        primary: cBlueBack
    ),
    onPressed: () async {
    setState(() {
    _eingabeFach.text.isEmpty
    ? _validateFach = true
        : _validateFach = false;
    _eingabeVorname.text.isEmpty
    ? _validateVorname = true
        : _validateVorname = false;
    _eingabeNachname.text.isEmpty
    ? _validateNachname = true
        : _validateNachname = false;
    _eingabeTermin.text.isEmpty
    ? _validateTermin = true
        : _validateTermin = false;
    _eingabeKlasse.text.isEmpty
    ? _validateKlasse = true
        : _validateKlasse = false;
    _eingabeNummer.text.isEmpty
    ? _validateNummer = true
        : _validateNummer = false;
    });
    if (
    _eingabeFach.text.isNotEmpty &&

    _eingabeVorname.text.isNotEmpty &&

    _eingabeNachname.text.isNotEmpty &&

    _eingabeNummer.text.isNotEmpty &&

    _eingabeKlasse.text.isNotEmpty &&

    _eingabeTermin.text.isNotEmpty ) {
    await DatabaseService()
        .addSchueler(aktSchule, _eingabeVorname.text, _eingabeNachname.text, _eingabeNummer.text, _eingabeFach.text, _eingabeTermin.text, _eingabeKlasse.text);
    Navigator.pop(context);
    }},
    child: Text('Submit', style: TextStyle(color: cRand))
    )
    ]),
    ),
    );
    }
  }

