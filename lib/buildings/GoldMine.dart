import "package:islands/buildings/Building.dart";
import "package:islands/Curves.dart";
import "package:meta/meta.dart";
import "package:islands/Island.dart";

class GoldMine extends Building {
  int gold;

  GoldMine(
      {@required Island myIsland,
      @required int level,
      bool isUpgrading,
      DateTime upgradeCompletionDate})
      : super(
            myIsland: myIsland,
            level: level,
            isUpgrading: isUpgrading,
            upgradeCompletionDate: upgradeCompletionDate);

  @override
  void syncWhileUpgrading(Duration timeSinceLastSync) {
    //nothing to do here, can't mine any gold while upgrading
  }

  @override
  void syncWhileNotUpgrading(Duration timeSinceLastSync) {
    int goldPerSync =
        Curves.standardCurve(super.level) * timeSinceLastSync.inSeconds;
    gold += goldPerSync;
  }

  @override
  int costForUpgrade() {
    int initialCost = 100;
    int costMultiplier = Curves.standardCurve(super.level + 1);

    return initialCost * costMultiplier;
  }
}
