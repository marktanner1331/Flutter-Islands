import "package:meta/meta.dart";
import "package:islands/Island.dart";
import "package:islands/Curves.dart";
import "package:islands/Data.dart";

abstract class Building {
  //TODO make these private set
  int level;
  bool isUpgrading;
  DateTime upgradeCompletionDate;
  Island myIsland;

  Building(
      {@required this.myIsland,
      @required this.level,
      this.isUpgrading = false,
      this.upgradeCompletionDate})
      : assert(isUpgrading == false && upgradeCompletionDate == null),
        assert(isUpgrading &&
            upgradeCompletionDate != null &&
            upgradeCompletionDate.isAfter(DateTime.now()));

  ///starts the upgrade of the building
  ///assumes the building is upgradable
  ///does not subtract gold from the gold mine
  void upgrade() {
    assert(isUpgrading == false);

    int hoursNeeded =
        Data.mainIsland.researchFacility.hoursNeededForUpgrade(this);

    upgradeCompletionDate = DateTime.now().add(Duration(hours: hoursNeeded));
    isUpgrading = true;
  }

  int costForUpgrade();

  ///best not to override this method, override syncWhileUpgrading() and syncWhileNotUpgrading() instead
  @mustCallSuper
  void sync(Duration timeSinceLastSync) {
    //while buildings are upgrading, normal operations (such as gold mining) are suspended

    if (isUpgrading) {
      if (upgradeCompletionDate.isBefore(DateTime.now())) {
        //the upgrade completed somewhere between the last sync and now

        DateTime lastSyncTime = DateTime.now().subtract(timeSinceLastSync);

        Duration timeSpentUpgrading =
            upgradeCompletionDate.difference(lastSyncTime);
        Duration timeSpentAfterUpgrading =
            DateTime.now().difference(upgradeCompletionDate);

        assert(
            timeSpentUpgrading + timeSpentAfterUpgrading == timeSinceLastSync);

        syncWhileUpgrading(timeSpentUpgrading);

        level++;
        isUpgrading = false;
        upgradeCompletionDate = null;

        syncWhileNotUpgrading(timeSpentAfterUpgrading);
      } else {
        //the upgrade hasn't finished yet

        syncWhileUpgrading(timeSinceLastSync);
        syncWhileNotUpgrading(Duration.zero);
      }
    } else {
      //not upgrading, all of those lovely ticks can be used normally

      syncWhileUpgrading(Duration.zero);
      syncWhileNotUpgrading(timeSinceLastSync);
    }
  }

  void syncWhileUpgrading(Duration timeSinceLastSync);
  void syncWhileNotUpgrading(Duration timeSinceLastSync);
}
