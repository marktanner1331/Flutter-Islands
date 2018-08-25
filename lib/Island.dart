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

  final GoldMine goldMine;
  final GoldRefinery goldRefinery;
  final Barracks barracks;
  final Shipyard shipyard;
  final CannonFactory cannonFactory;
  final ResearchFacility researchFacility;

  Island(
      {@required this.isMainIsland,
      @required this.gold,
      @required int goldMineLevel,
      @required int goldRefineryLevel,
      @required int barracksLevel,
      @required int shipyardLevel,
      @required int cannonFactoryLevel,
      @required int researchFacilityLevel})
      : goldMine = GoldMine(goldMineLevel),
        goldRefinery = GoldRefinery(goldRefineryLevel),
        barracks = Barracks(barracksLevel),
        shipyard = Shipyard(shipyardLevel),
        cannonFactory = CannonFactory(cannonFactoryLevel),
        researchFacility = ResearchFacility(researchFacilityLevel);

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
