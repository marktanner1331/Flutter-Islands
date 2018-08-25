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
    List<Widget> buildingButtons = List<Widget>();

    buildingButtons.add(FlatButton(
        child: Text("Gold Mine (Level : ${widget.island.goldMine.level})"),
        onPressed: () => print("did click gold mine")));

    if (widget.island.goldRefinery.level > 0) {
      buildingButtons.add(FlatButton(
          child: Text(
              "Gold Refinery (Level : ${widget.island.goldRefinery.level})"),
          onPressed: () => print("did click gold Refinery")));
    }

    buildingButtons.add(FlatButton(
        child: Text("Barracks (Level : ${widget.island.barracks.level})"),
        onPressed: () => print("did click barracks")));

    buildingButtons.add(FlatButton(
        child: Text("Shipyard (Level : ${widget.island.shipyard.level})"),
        onPressed: () => print("did click shipyard")));

    if (widget.island.cannonFactory.level > 0) {
      buildingButtons.add(FlatButton(
          child: Text(
              "Cannon Factory (Level : ${widget.island.cannonFactory.level})"),
          onPressed: () => print("did click cannon factory")));
    }

    buildingButtons.add(FlatButton(
        child: Text("Research Facility"),
        onPressed: () => print("did click research facility")));

    return new Scaffold(
      appBar: new AppBar(
        title: Text("Island Overview"),
      ),
      body: Column(
        children: buildingButtons,
      ),
    );
  }
}
