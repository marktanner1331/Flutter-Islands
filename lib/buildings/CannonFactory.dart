import "package:islands/buildings/Building.dart";
import "package:islands/Island.dart";
import "package:islands/Curves.dart";

class CannonFactory extends Building {
   CannonFactory(
      Island myIsland,
      int level,
      {bool isUpgrading,
      DateTime upgradeCompletionDate})
      : super(
            myIsland: myIsland,
            level: level,
            isUpgrading: isUpgrading,
            upgradeCompletionDate: upgradeCompletionDate);

  @override
  void syncWhileUpgrading(Duration timeSinceLastSync) {
    //nothing to do here, can't refine any gold while upgrading
  }

  @override
  void syncWhileNotUpgrading(Duration timeSinceLastSync) {
    int goldPerSync =
        Curves.standardCurve(super.level) * timeSinceLastSync.inSeconds;
    
    super.myIsland.gold += goldPerSync;
  }

  @override
  int costForUpgrade() {
    int initialCost = 100;
    int costMultiplier = Curves.standardCurve(super.level + 1);

    return initialCost * costMultiplier;
  }
}