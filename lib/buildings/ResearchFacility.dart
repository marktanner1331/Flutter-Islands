import "package:islands/buildings/Building.dart";
import "GoldMine.dart";
import "package:meta/meta.dart";
import "package:islands/Island.dart";
import "package:islands/Curves.dart";
import "package:islands/Data.dart";

class ResearchFacility extends Building {
  get betterPickaxes => _betterPickaxes.isUpgraded;
  ReseachItem _betterPickaxes = ReseachItem(
      researchFactoryLevelPrerequisite: 1, upgradeDuration: Duration(hours: 1));

  get heavyLiftingEquipment => _heavyLiftingEquipment.isUpgraded;
  ReseachItem _heavyLiftingEquipment = ReseachItem(
      researchFactoryLevelPrerequisite: 1, upgradeDuration: Duration(hours: 1));

  get explosives => _explosives.isUpgraded;
  ReseachItem _explosives = ReseachItem(
      researchFactoryLevelPrerequisite: 1, upgradeDuration: Duration(hours: 1));

  get fasterBuilding => _fasterBuilding.isUpgraded;
  ReseachItem _fasterBuilding = ReseachItem(
      researchFactoryLevelPrerequisite: 1, upgradeDuration: Duration(hours: 1));

  ReseachItem _currentResearchItem;
  DateTime _currentResearchItemCompletionDate;

  ResearchFacility(Island myIsland, int level,
      {bool isUpgrading, DateTime upgradeCompletionDate})
      : super(
            myIsland: myIsland,
            level: level,
            isUpgrading: isUpgrading,
            upgradeCompletionDate: upgradeCompletionDate);

  bool isBuildingUpgradable(Building building) {
    switch (building.runtimeType) {
      case GoldMine:
        if (building.level < 5) {
          return true;
        } else if (building.level < 10) {
          return betterPickaxes;
        } else if (building.level < 15) {
          return heavyLiftingEquipment;
        } else if (building.level < 20) {
          return explosives;
        }
        break;
      case ResearchFacility:
        int maxLevel = Data.currentMap * 4;
        assert(maxLevel <= 20);

        return level < maxLevel;
        break;
    }

    throw new Exception();
  }

  int hoursNeededForUpgrade(Building building) {
    int normalHoursNeeded = Curves.standardCurve(building.level + 1);
    if (fasterBuilding) {
      normalHoursNeeded = (normalHoursNeeded / 2).ceil();
    }

    return normalHoursNeeded;
  }

  @override
  int costForUpgrade() {
    int initialCost = 500;
    int costMultiplier = Curves.standardCurve(super.level + 1);

    return initialCost * costMultiplier;
  }

  @override
  void syncWhileNotUpgrading(Duration timeSinceLastSync) {
    if (_currentResearchItem != null) {
      if (_currentResearchItemCompletionDate.isBefore(DateTime.now())) {
        _currentResearchItem.isUpgraded = true;
        _currentResearchItem = null;
        _currentResearchItemCompletionDate = null;
      }
    }
  }

  @override
  void syncWhileUpgrading(Duration timeSinceLastSync) {
    //no research can be done while upgrading
  }
}

class ReseachItem {
  final Duration upgradeDuration;
  final int researchFactoryLevelPrerequisite;
  bool isUpgraded = false;

  ReseachItem({this.upgradeDuration, this.researchFactoryLevelPrerequisite});
}
