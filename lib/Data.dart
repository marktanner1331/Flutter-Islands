import "./Island.dart";

class Data {
  static Island mainIsland;
  static DateTime _lastSynced;

  static List<Island> islands;

  ///A player progresses through maps, unlocking new research opportunities
  ///at each level
  ///from 0 (tutorial) through to 5
  static int currentMap = 0;

  static void init() {
    islands = List<Island>();

    mainIsland = Island(
        isMainIsland: true,
        gold: 100,
        goldMineLevel: 1,
        goldRefineryLevel: 0,
        barracksLevel: 1,
        shipyardLevel: 1,
        cannonFactoryLevel: 0,
        researchFacilityLevel: 1);

    islands.add(mainIsland);
  }

  static void sync() {
    Duration timeSinceLastSync = DateTime.now().difference(_lastSynced);

    for (Island island in islands) {
      island.sync(timeSinceLastSync);
    }

    _lastSynced = DateTime.now();
  }
}
