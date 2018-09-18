import "package:islands/buildings/Building.dart";
import "package:islands/Curves.dart";
import "package:meta/meta.dart";
import "package:islands/Island.dart";

class Barracks extends Building {
  static const String MERCENARY = "MERCENARY";
  static const String EXPLORER = "EXPLORER";

  int numMercenaries = 0;
  int numExplorers = 0;

  bool _isCurrentlyTraining = false;
  String _currentlyTrainingUnitName;
  int _currentlyTrainingAmount;

  ///the time at which the current unit has finished training
  DateTime _currentlyTrainingFinishTime;

  Barracks(
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
    //if we are not currently training anything, we are done
    if (_isCurrentlyTraining == false) {
      return;
    }

    //if we haven't finished training the current unit, we are done
    if (_currentlyTrainingFinishTime.isAfter(DateTime.now())) {
      return;
    }

    //if we have finished training the current unit, and there are none left to train
    //we are done
    if (_currentlyTrainingAmount == 1) {
      _increaseUnitCount(_currentlyTrainingUnitName, 1);

      _currentlyTrainingAmount = 0;
      _isCurrentlyTraining = false;
      _currentlyTrainingUnitName = null;
      _currentlyTrainingFinishTime = null;

      return;
    }

    //if we get to here, it means there are multiple units needing training
    //and the most recent sync was a long time ago, so multiple units will have been trained in that time
    DateTime lastSync = DateTime.now().subtract(timeSinceLastSync);

    Duration timeRemainingOnCurrentUnit =
        lastSync.difference(_currentlyTrainingFinishTime);
    assert(timeRemainingOnCurrentUnit.inSeconds > 0);

    //crawl forward to the point the current unit has been trained
    timeSinceLastSync -= timeRemainingOnCurrentUnit;

    _increaseUnitCount(_currentlyTrainingUnitName, 1);

    _currentlyTrainingAmount--;

    //now we need to see how many other units have been trained in the time since the last sync
    Duration trainingDuration = getTrainingDuration(_currentlyTrainingUnitName);
    int numUnitsTrained =
        (timeSinceLastSync.inSeconds / trainingDuration.inSeconds).floor();

    //if we have trained all the queued units, great, we are done
    if (_currentlyTrainingAmount <= numUnitsTrained) {
      _increaseUnitCount(_currentlyTrainingUnitName, _currentlyTrainingAmount);

      _currentlyTrainingAmount = 0;
      _isCurrentlyTraining = false;
      _currentlyTrainingUnitName = null;
      _currentlyTrainingFinishTime = null;

      return;
    }

    //if we get here, it means that we have trained some of the units
    //but there are still more to go

    _increaseUnitCount(_currentlyTrainingUnitName, numUnitsTrained);

    //we crawl forward past training those units
    timeSinceLastSync -= trainingDuration * numUnitsTrained;
    assert(timeSinceLastSync.inSeconds > 0);

    //now we need to figure out when the next one will finish
    Duration timeLeftOnCurrentUnit = trainingDuration - timeSinceLastSync;

    assert(timeLeftOnCurrentUnit.inSeconds > 0);

    _currentlyTrainingFinishTime = DateTime.now().add(timeLeftOnCurrentUnit);
  }

  void _increaseUnitCount(String unitName, int amount) {
    switch (unitName) {
      case MERCENARY:
        numMercenaries += amount;
        break;
      case EXPLORER:
        numExplorers += amount;
        break;
      default:
        throw new Error();
    }
  }

  Duration getTrainingDuration(String unitName) {
    double baseTime;
    switch (unitName) {
      case MERCENARY:
        baseTime = 5.0;
        break;
      case EXPLORER:
        baseTime = 50.0;
        break;
      default:
        throw new Error();
    }

    baseTime /= super.level;

    return Duration(minutes: (baseTime * 60).round());
  }

  @override
  int costForUpgrade() {
    int initialCost = 100;
    int costMultiplier = Curves.standardCurve(super.level + 1);

    return initialCost * costMultiplier;
  }
}
