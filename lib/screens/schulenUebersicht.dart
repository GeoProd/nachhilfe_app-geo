import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nachhilfe/data.dart';
import 'package:nachhilfe/models/schule.dart';
import 'package:nachhilfe/screens/schuelerUebersicht.dart';
import 'package:nachhilfe/services/auth.dart';
import 'package:nachhilfe/services/database.dart';
import 'package:provider/provider.dart';

class SchulenUebersicht extends StatefulWidget {
  @override
  _SchulenUebersichtState createState() => _SchulenUebersichtState();
}

class _SchulenUebersichtState extends State<SchulenUebersicht> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Schule>?>.value(
        initialData: null,
        // We are using this stream to wrap the rest of the widget
        value: DatabaseService().dataSchule,
        child: schulenUebersicht());
  }
}

class schulenUebersicht extends StatefulWidget {
  const schulenUebersicht({Key? key}) : super(key: key);

  @override
  _schulenUebersichtState createState() => _schulenUebersichtState();
}

class _schulenUebersichtState extends State<schulenUebersicht> {
  String key = '';
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<List<Schule>?>(context);
    data?.sort((a, b) => b.ort.compareTo(a.ort));
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
            title: Text(
                "Welcome to Lern Centro",
              textAlign: TextAlign.center,
            ),
            backgroundColor: cBlue,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  icon: Icon(Icons.logout))
            ]),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/S5.jpg'),
              fit: BoxFit.cover
            )
          ),
          child: ListView.builder(
            reverse: false,
            itemCount: data?.length != null ? data?.length : 0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return _listItem(data, index); //index == 0 ? _searchBar() : _
            },
          ),
        ));
  }



_listItem(data, i) {
  return Container(
    height: 185,
    child: Card(
      shadowColor: cDeutsch,
        elevation: 20,
        shape: CircleBorder(),
        child: new InkWell(
          onTap: () => {
            aktSchule = data[i].id,
            //Navigator.pop(context),
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SchuelerUebersicht()), //id:data[i].id
            )
          },
          child: Container(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/Lo.png',
                  height: 125,
                  width: 300,
                ),
                Text(
                  data[i].ort, //data?[i].ort != null ? data[i].ort : '',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: cBlack
                  ),
                ),
              ],
            ),
          ),
        )),
  );
}

// _listItem(data, i) {
//   return Container(
//     height: 185,
//     child: Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25),
//           //borderRadius: BorderRadius.circular(100),
//         ),
//         child: new InkWell(
//           onTap: () => {
//             aktSchule = data[i].id,
//             //Navigator.pop(context),
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => SchuelerUebersicht()), //id:data[i].id
//             )
//           },
//           child: Container(
//             child: Column(
//               children: [
//                 Image.asset(
//                   'assets/images/Lo.png',
//                   height: 125,
//                   width: 300,
//                 ),
//                 Text(
//                   data[i].ort, //data?[i].ort != null ? data[i].ort : '',
//                   style: TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     color: cBlack
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )),
//   );
// }

}
// child: Padding(
// padding: const EdgeInsets.only(
// top: 10.0, bottom: 10.0, left: 0.0, right: 0.0),
// child: ListTile(
// leading: Image.asset('assets/images/Lo.png'),
// title: Text(
// data[i].ort, //data?[i].ort != null ? data[i].ort : '',
// style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
// ),
// ),
// ),

//Circle shape
// _listItem(data, i) {
//   return Container(
//     height: 185,
//     child: Card(
//         elevation: 3,
//         shape: CircleBorder(),
//         child: new InkWell(
//           onTap: () => {
//             aktSchule = data[i].id,
//             //Navigator.pop(context),
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => SchuelerUebersicht()), //id:data[i].id
//             )
//           },
//           child: Container(
//             child: Column(
//               children: [
//                 Image.asset(
//                   'assets/images/Lo.png',
//                   height: 125,
//                   width: 300,
//                 ),
//                 Text(
//                   data[i].ort, //data?[i].ort != null ? data[i].ort : '',
//                   style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                       color: cBlack
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )),
//   );
// }

//rectangle
// _listItem(data, i) {
//   return Container(
//     height: 185,
//     child: Card(
//         elevation: 3,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25),
//           //borderRadius: BorderRadius.circular(100),
//         ),
//         child: new InkWell(
//           onTap: () => {
//             aktSchule = data[i].id,
//             //Navigator.pop(context),
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => SchuelerUebersicht()), //id:data[i].id
//             )
//           },
//           child: Container(
//             child: Column(
//               children: [
//                 Image.asset(
//                   'assets/images/Lo.png',
//                   height: 125,
//                   width: 300,
//                 ),
//                 Text(
//                   data[i].ort, //data?[i].ort != null ? data[i].ort : '',
//                   style: TextStyle(
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                       color: cBlack
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )),
//   );
// }