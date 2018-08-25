import 'package:flutter/material.dart';
import "views/IslandOverview.dart";
import "./Data.dart";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  MyApp() {
    Data.init();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IslandOverview(island: Data.mainIsland),
    );
  }
}