import "package:islands/buildings/Building.dart";

class GoldMine extends Building {
  //describes the amount of gold per second for each level
  static Map<int, int> goldPerSecond = {
    1: standardCurve(1),
    2: standardCurve(2),
    3: standardCurve(3),
    4: standardCurve(4),
    5: standardCurve(5),
    6: standardCurve(6),
    7: standardCurve(7),
    8: standardCurve(8),
    9: standardCurve(9),
    10: standardCurve(10),
    11: standardCurve(11),
    12: standardCurve(12),
    13: standardCurve(13),
    14: standardCurve(14),
    15: standardCurve(15),
    16: standardCurve(16),
    17: standardCurve(17),
    18: standardCurve(18),
    19: standardCurve(19),
    20: standardCurve(20),
  };

  GoldMine(int level) : super(level);

  void sync(Duration timeSinceLastSync) {
    int gold =
  }

  static int standardCurve(int value) {
    return ((8.0 * value) / 171.0 + (91.0 * value) / 57.0 - (110.0 / 171.0)).round();
  }
}