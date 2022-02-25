import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nachhilfe/models/schueler.dart';
import 'package:nachhilfe/screens/schuelerInformation.dart';
import 'package:nachhilfe/screens/terminUebersicht.dart';
import 'package:nachhilfe/screens/schuelerErstellen.dart';
import 'package:nachhilfe/services/database.dart';
import 'package:provider/provider.dart';
import '../data.dart';

class SchuelerUebersicht extends StatefulWidget {
  @override
  _SchuelerUebersichtState createState() => _SchuelerUebersichtState();
}

class _SchuelerUebersichtState extends State<SchuelerUebersicht> {

  _SchuelerUebersichtState(); //this.id
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Schueler>?>.value(
        initialData: null,
        // We are using this stream to wrap the rest of the widget
        value: DatabaseService().dataSchueler(aktSchule),
        child: Container(
          child: schuelerUebersicht() //id:id
        )
    );
  }
}

class schuelerUebersicht extends StatefulWidget {
  @override
  _schuelerUebersichtState createState() => _schuelerUebersichtState();
}
class _schuelerUebersichtState extends State<schuelerUebersicht> {
  TextEditingController _searchController = TextEditingController();
  String key = '';
  late Future resultsLoaded;
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<List<Schueler>?>(context);
    data?.sort((a, b) => a.vorname.compareTo(b.vorname));

    return Scaffold(
        backgroundColor: cBlue2,
        appBar: AppBar(
            title: Text("Schüler Übersicht"),
            backgroundColor: cBlue,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                  onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const schuelerErstellen()
                        )
                    )
                  },
                  icon: Icon(Icons.person_add)
              )
            ]),
        body:Container(
          // decoration: BoxDecoration(
          //     image: DecorationImage(
          //         image: AssetImage('assets/images/S5.jpg'),
          //         fit: BoxFit.cover
          //     )
          // ),
            child: Column(
    children: <Widget>[

    Expanded(
    child: ListView.builder(
      itemCount: data?.length != null ? data?.length : 0,
      itemBuilder: (context, index) {
        return _listItem(data, index); //index == 0 ? _searchBar() :
      },
    )),
    ],
    ),
    ));
  }

  _listItem(data, i) {
    return Padding(
      padding: const EdgeInsets.only(top: 0, bottom: 0, left: 5.0, right: 5.0),
      child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
          child: new InkWell(
            onTap: () => {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TerminUebersicht(id: data[i].id, schueler: data[i])),
              )
            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 5.0, right: 5.0),
                child: ListTile(
                    title:Text(
                      data![i].vorname + " " + data![i].nachname,
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,),
                    ),subtitle: Text("Klasse: "+data![i].klasse ,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,)),
                  leading: CircleAvatar(
                    backgroundColor: data[i].klasse.contains("9") ||
                        data[i].klasse.contains("10")||
                        data[i].klasse.contains("11")||
                        data[i].klasse.contains("12")
                        ? Colors.black
                        : data[i].klasse.contains("9") ||
                        data[i].klasse.contains("8")||
                        data[i].klasse.contains("7")
                        ? cBlueBack
                        : data[i].klasse.contains("6") ||
                        data[i].klasse.contains("5")
                        ? Colors.green.shade400
                        : data[i].klasse.contains("4") ||
                        data[i].klasse.contains("3")
                        ? cAndere
                        :Colors.yellow,
                    child: Text(
                      data![i].vorname[0],
                      style:
                      TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                  ),
                  trailing: IconButton(
                    onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SchuelerInfo(schueler: data[i])),
                        )
                      },
                    icon: Icon(Icons.info_outline,color: cBlue)
                  ),

                //   trailing: ElevatedButton(
                //   style:ElevatedButton.styleFrom(
                //     primary: cBlueBack,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(180.0)
                //     )
                //   ),
                //
                //   onPressed: () => {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => SchuelerInfo(schueler: data[i])),
                //     )
                //   }
                //   , child: RichText(text: TextSpan(text:'Info',style:TextStyle(color:Colors.blue.shade700,fontWeight: FontWeight.bold)),),
                // ),
                ),
              ),
            ),
          )),
    );
  }

}





// @override
// void initState() {
//   super.initState();
//   _searchController.addListener(_onSearchChanged);
// }
// @override
// void didChangeDependencies() {
//   super.didChangeDependencies();
//   resultsLoaded = getUsersPastTripsStreamSnapshots(data, 1);
// }
//
//
// _onSearchChanged() {
//   searchResultsList();
// }
//
// searchResultsList() {
//   var showResults = [];
//
//   if(_searchController.text != "") {
//     for(var tripSnapshot in _allResults){
//       var title = Trip.fromSnapshot(tripSnapshot).title.toLowerCase();
//
//       if(title.contains(_searchController.text.toLowerCase())) {
//         showResults.add(tripSnapshot);
//       }
//     }
//
//   } else {
//     showResults = List.from(_allResults);
//   }
//   setState(() {
//     _resultsList = showResults;
//   });
// }
//
// getUsersPastTripsStreamSnapshots(data,i) async {
//   final data = Provider.of<List<Schueler>?>(context);
//
//   setState(() {
//     _allResults = data[i].vorname;
//   });
//   searchResultsList();
//   return "complete";
// }



/*

@override
Widget build(BuildContext context) {
  final schuelerListe = Provider.of<List<Schueler>?>(context);

  return Scaffold(
      body: ListView.builder(
          itemCount: schuelerListe?.length,
          itemBuilder: (context, i) {
            return schueler_name(schuelerListe, i);
          }
      )
  );
}

schueler_name(data, i) {
  return InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Eintragen(id: data[i].id)),//data.documentID)),
        )
      },
      child: Container(
        decoration: boxDecoration,
        margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(data[i].vorname),
                  Text(data[i].nachname),
                  Text(data[i].id),
                ]),
          ]),
        ),
      ));
}
}



*/


/*

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nachhilfe/models/schueler.dart';
import 'package:nachhilfe/screens/terminUebersicht.dart';
import 'package:nachhilfe/screens/schuelerErstellen.dart';
import 'package:nachhilfe/services/auth.dart';
import 'package:provider/provider.dart';

class schuelerUebersicht extends StatefulWidget {
  const schuelerUebersicht({Key? key}) : super(key: key);

  @override
  _schuelerUebersichtState createState() => _schuelerUebersichtState();
}

class _schuelerUebersichtState extends State<schuelerUebersicht> {
  // List<Names> searchNames = [];
  // List<Names> filteredImbiss = [];
  // initState() {
  //   searchNames = Provider.of<List<Names>>(context);
  //   filteredImbiss = searchNames;
  //
  //   super.initState();
  // }
  String key = '';
  // TextEditingController _searchController = TextEditingController();
  // late Future resultsLoaded;
  // List _allResults = [];
  // List _resultsList = [];
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _searchController.addListener(_onSearchChanged);
  // }
  // @override
  // void dispose() {
  //   _searchController.removeListener(_onSearchChanged);
  //   _searchController.dispose();
  //   super.dispose();
  // }
  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   resultsLoaded = getUsersPastTripsStreamSnapshots();
  // }
  //
  // _onSearchChanged() {
  //   searchResultsList();
  // }
  //
  // searchResultsList() {
  //   var showResults = [];
  //
  //   if(_searchController.text != "") {
  //     for(var tripSnapshot in _allResults){
  //       var title = Trip.fromSnapshot(tripSnapshot).title.toLowerCase();
  //
  //       if(title.contains(_searchController.text.toLowerCase())) {
  //         showResults.add(tripSnapshot);
  //       }
  //     }
  //
  //   } else {
  //     showResults = List.from(_allResults);
  //   }
  //   setState(() {
  //     _resultsList = showResults;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<List<Schueler>?>(context);
    //var names = Provider.of<List<Names>?>(context);
    var names = Provider.of<List<Schueler>?>(context);

    setState(() {
      names = names?.where((data) {
        return data.vorname.contains(key);
      }).toList();
    });

    return Scaffold(
        body: ListView.builder(
      itemCount: data?.length,
      itemBuilder: (context, index) {
        return index == 0 ? _searchBar() : _listItem(data, index);
      },
    ));
  }



  _listItem(data, id) {
    return Card(
        child: new InkWell(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => schueler(id: id)),
        )
      },
      child: Padding(
        padding: const EdgeInsets.only(
            top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              data[id].vorname + " " + data[id].nachname,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            // Text(
            //   data[id].vorname,
            //   style: TextStyle(
            //       color: Colors.grey.shade600
            //   ),
            // ),
          ],
        ),
      ),
    ));
  }
}

//   schueler_name(data, id) {
//     return InkWell(
//         onTap: () => {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => schueler(id: id)),
//               )
//             },
//         child: Container(
//           decoration: boxDecoration,
//           margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
//           child: Container(
//             padding: EdgeInsets.all(10),
//             child: Column(children: [
//               Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text(data[id].vorname),
//                     Text(data[id].nachname),
//                   ]),
//             ]),
//           ),
//         ));
//   }
// }






class SearchList extends StatefulWidget {
  //SearchList({ Key key }) : super(key: key);
  @override
  _SearchListState createState() => new _SearchListState();

}

class _SearchListState extends State<SearchList>
{
  final list = Provider.of<List<Schueler>?>;
  final AuthService _auth = AuthService();

  Widget appBarTitle = new Text("LernO", style: new TextStyle(color: Colors.white),);
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list = [];
  bool _IsSearching = false;
  String _searchText = "";

  _SearchListState() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      }
      else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    //init();

  }

  /*void init() {
    _list = [];

    _list.add("Google");
    _list.add("IOS");
    _list.add("Andorid");
    _list.add("Dart");
    _list.add("Flutter");
    _list.add("Python");
    _list.add("React");
    _list.add("Xamarin");
    _list.add("Kotlin");
    _list.add("Java");
    _list.add("RxAndroid");
  }*/

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      appBar: buildBar(context),
      body: new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: _IsSearching ? _buildSearchList() : _buildList(),
      ),
    );
  }

  List<ChildItem> _buildList() {
    return _list.map((contact) => new ChildItem(contact)).toList();
  }

  List<ChildItem> _buildSearchList() {
    if (_searchText.isEmpty) {
      return _list.map((contact) => new ChildItem(contact))
          .toList();
    }
    else {
      List<String> _searchList = [];
      for (int i = 0; i < _list.length; i++) {
        String  name = _list.elementAt(i);
        if (name.toLowerCase().contains(_searchText.toLowerCase())) {
          _searchList.add(name);
        }
      }
      return _searchList.map((contact) => new ChildItem(contact))
          .toList();
    }
  }

  buildBar(BuildContext context) {
    return new AppBar(
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          new IconButton(icon: actionIcon, onPressed: () {
            setState(() {
              if (this.actionIcon.icon == Icons.search) {
                this.actionIcon = new Icon(Icons.close, color: Colors.white,);
                this.appBarTitle = new TextField(
                  controller: _searchQuery,
                  style: new TextStyle(
                    color: Colors.white,

                  ),
                  decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search, color: Colors.white),
                      hintText: "Suchen...",
                      hintStyle: new TextStyle(color: Colors.white)
                  ),
                );
                _handleSearchStart();
              }
              else {
                _handleSearchEnd();
              }
            });
          },),
          TextButton(
            child: Text("Logout", style: TextStyle(color: Colors.white)),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
          IconButton(
              onPressed: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        const schuelerErstellen()
                    )
                )
              },
              icon: Icon(Icons.person_add))
        ]
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
      new Text("LernO", style: new TextStyle(color: Colors.white),);
      _IsSearching = false;
      _searchQuery.clear();
    });
  }

}

class ChildItem extends StatelessWidget {
  final String name;
  ChildItem(this.name);
  @override
  Widget build(BuildContext context) {
    return new ListTile(title: new Text(this.name));
  }

}










/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nachhilfe/models/schueler.dart';
import 'package:nachhilfe/screens/terminUebersicht.dart';
import 'package:nachhilfe/screens/schueler.dart';
import 'package:provider/provider.dart';

class schuelerUebersicht extends StatefulWidget {
  const schuelerUebersicht({Key? key}) : super(key: key);

  @override
  _schuelerUebersichtState createState() => _schuelerUebersichtState();
}

class _schuelerUebersichtState extends State<schuelerUebersicht> {
  // List<Names> searchNames = [];
  // List<Names> filteredImbiss = [];
  // initState() {
  //   searchNames = Provider.of<List<Names>>(context);
  //   filteredImbiss = searchNames;
  //
  //   super.initState();
  // }
  String key = '';
  // TextEditingController _searchController = TextEditingController();
  // late Future resultsLoaded;
  // List _allResults = [];
  // List _resultsList = [];
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _searchController.addListener(_onSearchChanged);
  // }
  // @override
  // void dispose() {
  //   _searchController.removeListener(_onSearchChanged);
  //   _searchController.dispose();
  //   super.dispose();
  // }
  //
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   resultsLoaded = getUsersPastTripsStreamSnapshots();
  // }
  //
  // _onSearchChanged() {
  //   searchResultsList();
  // }
  //
  // searchResultsList() {
  //   var showResults = [];
  //
  //   if(_searchController.text != "") {
  //     for(var tripSnapshot in _allResults){
  //       var title = Trip.fromSnapshot(tripSnapshot).title.toLowerCase();
  //
  //       if(title.contains(_searchController.text.toLowerCase())) {
  //         showResults.add(tripSnapshot);
  //       }
  //     }
  //
  //   } else {
  //     showResults = List.from(_allResults);
  //   }
  //   setState(() {
  //     _resultsList = showResults;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<List<Schueler>?>(context);
    //var names = Provider.of<List<Names>?>(context);
    var names = Provider.of<List<Schueler>?>(context);

    setState(() {
      names = names?.where((data) {
        return data.vorname.contains(key);
      }).toList();
    });

    return Scaffold(
        body: ListView.builder(
          itemCount: data?.length,
          itemBuilder: (context, index) {
            return index == 0 ? _searchBar() : _listItem(data, index);
          },
        ));
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        //controller: _searchController,
        decoration: InputDecoration(hintText: 'Search...'),
        onChanged: (text) {
          setState(() => key = text);
          text = text.toLowerCase();
        },
      ),
    );
  }

  _listItem(data, id) {
    return Card(
        child: new InkWell(
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => schueler(id: id)),
            )
          },
          child: Padding(
            padding: const EdgeInsets.only(
                top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data[id].vorname + " " + data[id].nachname,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   data[id].vorname,
                //   style: TextStyle(
                //       color: Colors.grey.shade600
                //   ),
                // ),
              ],
            ),
          ),
        ));
  }
}

//   schueler_name(data, id) {
//     return InkWell(
//         onTap: () => {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => schueler(id: id)),
//               )
//             },
//         child: Container(
//           decoration: boxDecoration,
//           margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 0),
//           child: Container(
//             padding: EdgeInsets.all(10),
//             child: Column(children: [
//               Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text(data[id].vorname),
//                     Text(data[id].nachname),
//                   ]),
//             ]),
//           ),
//         ));
//   }
// }
*/*/