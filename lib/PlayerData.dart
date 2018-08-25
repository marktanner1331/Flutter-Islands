import "./Island.dart";

class PlayerData {
  static Island mainIsland;

  static void init() {
    mainIsland = Island(
        isMainIsland: true,
        gold: 100,
        goldMineLevel: 1,
        goldRefineryLevel: 0,
        barracksLevel: 1,
        shipyardLevel: 1,
        cannonFactoryLevel: 0,
        researchFacilityLevel: 1);
  }
}
