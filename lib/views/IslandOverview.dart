import "../Island.dart";
import 'package:flutter/material.dart';

class IslandOverview extends StatefulWidget {
  Island island;

  IslandOverview({Key key, @required this.island}) : super(key: key);

  @override
  _IslandOverviewState createState() => new _IslandOverviewState();
}

class _IslandOverviewState extends State<IslandOverview> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Island Overview"),
      ),
      body: Column(
        children: <Widget>[
          FlatButton(
              child: Text("Gold Mine (Level : ${widget.island.goldMine.level}"),
              onPressed: () => print("did click gold mine"))
        ],
      ),
    );
  }
}
