import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nachhilfe/screens/terminUebersicht.dart';
import 'package:nachhilfe/data.dart';
import 'package:nachhilfe/models/schueler.dart';
import 'package:firebase_auth/firebase_auth.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //final UserCredential user = await _auth.currentUser();
  //final userid = user.uid;

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<List<Schueler>?>(context);

    return ListView(
      children: <Widget>[
        datum(),
        termin(data, 0),
        termin(data, 1),
      ],
    );
  }

  datum() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(onPressed: null, icon: Icon(Icons.navigate_before)),
          //Text(termine[0][4]),
          IconButton(onPressed: null, icon: Icon(Icons.navigate_next)),
        ]);
  }

  termin(data, id) {
    return InkWell(
      onTap: () => {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => TerminUebersicht(id: id, )),
        // )
      },
      child: Container(
        decoration: boxDecoration,
        margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //Text(termine[id][0]),
                      //Text(termine[id][1]),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(data[id].vorname),
                      Text(data[id].nachname),
                    ])
              ]),
        ),
      ),
    );
  }
}
