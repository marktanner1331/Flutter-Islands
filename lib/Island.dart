import "package:islands/buildings/GoldMine.dart";
import "package:islands/buildings/GoldRefinery.dart";
import "package:islands/buildings/Barracks.dart";
import "package:islands/buildings/Shipyard.dart";
import "package:islands/buildings/CannonFactory.dart";
import "package:islands/buildings/ResearchFacility.dart";
import "package:meta/meta.dart";
import "package:islands/buildings/Building.dart";

class Island {
  final bool isMainIsland;
  int gold;

  GoldMine goldMine;
  GoldRefinery goldRefinery;
  Barracks barracks;
  Shipyard shipyard;
  CannonFactory cannonFactory;
  ResearchFacility researchFacility;

  Island(
      {@required this.isMainIsland,
      @required this.gold,
      @required int goldMineLevel,
      @required int goldRefineryLevel,
      @required int barracksLevel,
      @required int shipyardLevel,
      @required int cannonFactoryLevel,
      @required int researchFacilityLevel}) {
        goldMine = GoldMine(this, goldMineLevel);
        goldRefinery = GoldRefinery(this, goldRefineryLevel);
        barracks = Barracks(this, barracksLevel);
        shipyard = Shipyard(this, shipyardLevel);
        cannonFactory = CannonFactory(this, cannonFactoryLevel);
        researchFacility = ResearchFacility(this, researchFacilityLevel);
      }

  void sync(Duration timeSyncLastSync) {
    for(Building building in _getAllBuildings()) {
      building.sync(timeSyncLastSync);
    }
  }

  List<Building> _getAllBuildings() {
    return [
      goldMine,
      goldRefinery,
      barracks,
      shipyard,
      cannonFactory,
      researchFacility
    ];
  }
}
