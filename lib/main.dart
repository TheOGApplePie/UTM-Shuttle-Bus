// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UTM Shuttle Bus Student',
      theme: ThemeData( 
        primarySwatch: Colors.blue,
      ),
      home: const SelectionScreen(title: "UTM Shuttle Bus",));
  }
}
class SelectionScreen extends StatelessWidget{
  final title;
  const SelectionScreen({Key? key, required this.title}):super(key: key);
@override
Widget build (BuildContext context){
  return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(child: Column(children: [const Text("Select Route"),TextButton(
          onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context)=> const RouteTimeTableScreen(route: "SG")));
          }, child: const Text("St. George")), 
          TextButton(
            onPressed: () {
            Navigator.push(
              context, 
              MaterialPageRoute(builder: (context)=> const RouteTimeTableScreen(route: "SH")));
          }, child: const Text("Sheridan"))
            ],),
      ),
    );
}
}

class RouteTimeTableScreen extends StatefulWidget{
  final route;

  const RouteTimeTableScreen({Key? key, required this.route}) : super(key: key);
  @override
  _RouteTimeTableScreen createState() => _RouteTimeTableScreen();
}

class _RouteTimeTableScreen extends State<RouteTimeTableScreen>{
      var dropDownValue = 'Mississauga';
      var rows = <DataRow>[];
      
  @override
  Widget build(BuildContext context) {
    List<String> stopList;
    String title;
    if(widget.route == "SG"){
      title = "St. George";
      stopList = <String>['Mississauga', 'Hart House'];
    }else{
      title= "Sheridan";
      stopList = <String>['Mississauga', 'Sheridan'];
    }
    refreshStopData();
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(child:  ListView(children: [DropdownButton(
        value: dropDownValue, onChanged: (String? newValue){
        setState(() {
          dropDownValue = newValue!;
          refreshStopData();
        });
      }, items: stopList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList()), DataTable(
        columns: <DataColumn>[DataColumn(label: Text("Time")), DataColumn(label: Text("On Time?"))], 
        rows: rows)],),),
      ),
    );
  }
  
void refreshStopData() {
  rows.clear();
  var late = Random();
    for(int i = 7;i<24;i++){
        rows.add(DataRow(cells: <DataCell>[DataCell(Text(i.toString()+":00")),DataCell(Text(late.nextBool().toString()))]));
      }
}
  
}



