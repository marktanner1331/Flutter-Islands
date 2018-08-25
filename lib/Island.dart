import "package:islands/buildings/GoldMine.dart";

class Island {
  bool isMainIsland;
  int gold;

  GoldMine goldMine;

  Island(this.isMainIsland, this.gold, int goldMineLevel) : goldMine = GoldMine(goldMineLevel);
}
