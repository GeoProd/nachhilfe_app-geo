import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:nachhilfe/services/database.dart';
import 'package:signature/signature.dart';
import '../data.dart';

class Eintragen extends StatefulWidget {
  final String id;

  const Eintragen({
    required this.id,
  });

  @override
  _EintragenState createState() => _EintragenState(id); //terminId
}

class _EintragenState extends State<Eintragen> {
  final TextEditingController _eingabeFach = TextEditingController();
  bool _validateFach = false;
  final TextEditingController _eingabeThema = TextEditingController();
  bool _validateThema = false;
  final TextEditingController _eingabeBemerkung = TextEditingController();
  bool _validateBemerkung = false;
  final TextEditingController _eingabeLehrer = TextEditingController();
  bool _validateLehrer = false;

  bool unterschrift = true;
  bool datum = true;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FocusNode stateFocus = FocusNode();
  DateTime dateTime = DateTime.now();
  // String getText() {
  //   if (date == null) {
  //     return 'Select Date';
  //   } else {
  //     return DateFormat('MM/dd/yyyy').format(date);
  //     // return '${date.month}/${date.day}/${date.year}';
  //   }
  // }
  Timestamp? dateTimeStart;
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.red,
    exportBackgroundColor: Colors.blue,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  int validateAddress(String text) {
    if (text.isEmpty || text.length == 0) {
      return 1;
    } else {
      return 0;
    }
  }

  String id;

  _EintragenState(this.id);

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<MyUser?>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("LernCentro"),
          backgroundColor: cBlue,
          elevation: 0.0,
        ),
        //backgroundColor: cT,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/S5.jpg'),
                  fit: BoxFit.cover
              )
          ),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return termin_neu();
            },
          ),
        ));
  }

  termin_neu() {
    return Container(
      //color:cBlue,
      decoration: BoxDecoration(
          color: cBlue,
          border: Border.all(color: cBlue),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextFormField(
              focusNode: stateFocus,
              autofocus: true,
              controller: _eingabeFach,
              decoration: InputDecoration(
                errorText: _validateFach ? 'Bitte eintragen' : null,
                filled: true,
                fillColor: cTextField,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                hintText: 'Fach',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextField(
              controller: _eingabeThema,
              decoration: InputDecoration(
                errorText: _validateThema ? 'Bitte eintragen' : null,
                filled: true,
                fillColor: cTextField,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                hintText: 'Thema',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextField(
              controller: _eingabeBemerkung,
              decoration: InputDecoration(
                errorText: _validateBemerkung ? 'Bitte eintragen' : null,
                filled: true,
                fillColor: cTextField,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                hintText: 'Bemerkung',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextField(
              controller: _eingabeLehrer,
              decoration: InputDecoration(
                errorText: _validateLehrer ? 'Bitte eintragen' : null,
                filled: true,
                fillColor: cTextField,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                hintText: 'Name',
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
              onTap: () {
                // showDatePicker(context: context, initialDate: _dateTime! == null ? DateTime.now() : _dateTime!, firstDate: DateTime(2000),
                //     lastDate: DateTime(2050)).then((date) {setState(() {
                //
                // });});
                DatePicker.showDatePicker(context, showTitleActions: true,
                    onConfirm: (dateTime) {
                  dateTimeStart = Timestamp.fromDate(dateTime);
                },
                    currentTime: DateTime.now(),
                    locale: LocaleType.de);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: datum ? cBlue: cT ,
                  ),
                  borderRadius:
                  BorderRadius.all(Radius.circular(5)),
                  color: cBlueBack,
                ),
                child: Center(
                  child: Text(
                    "Datum Auswählen",
                    style: TextStyle(
                        color: cRand,
                        //fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
                  ),
                ),
              )),
              // Text(
              //   'Datum auswählen',
              //   style: TextStyle(color: Colors.white),
              // )),
          SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: unterschrift ? cBlue: cT ,
              ),
            ),
            child: Signature(
              controller: _controller,
              height: 150,
              backgroundColor: Colors.white,
            ),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: cBlueBack),
              onPressed: () async {
                setState(() {
                  dateTimeStart == null
                      ? datum = false
                      : datum = true;
                  _controller.isEmpty
                      ? unterschrift = false
                      : unterschrift = true;
                  _eingabeFach.text.isEmpty
                      ? _validateFach = true
                      : _validateFach = false;
                  _eingabeThema.text.isEmpty
                      ? _validateThema = true
                      : _validateThema = false;
                  _eingabeBemerkung.text.isEmpty
                      ? _validateBemerkung = true
                      : _validateBemerkung = false;
                  _eingabeLehrer.text.isEmpty
                      ? _validateLehrer = true
                      : _validateLehrer = false;
                });

                if (_eingabeFach.text.isNotEmpty &&
                    _eingabeThema.text.isNotEmpty &&
                    _eingabeBemerkung.text.isNotEmpty &&
                    _eingabeLehrer.text.isNotEmpty &&
                    _controller.isNotEmpty) {
                  final String picture =
                      "${DateTime.now().millisecondsSinceEpoch.toString()}.png";
                  Navigator.pop(context);
                  if (_controller.isNotEmpty) {
                    var data = await _controller.toPngBytes();
                    Uint8List listData = data!.buffer.asUint8List();
                    final FirebaseStorage storage = FirebaseStorage.instance;
                    await storage.ref().child(picture).putData(listData);
                  }
                  await DatabaseService().addTermin(
                    aktSchule,
                    id,
                    _eingabeFach.text,
                    _eingabeThema.text,
                    _eingabeBemerkung.text,
                    dateTimeStart!,
                    picture,
                    userID,
                    _eingabeLehrer.text,
                  );
                }
              },

              // },
              child: Text('Submit', style: TextStyle(color: cRand)))
        ]),
      ),
    );

  }
}
