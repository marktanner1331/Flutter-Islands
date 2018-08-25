abstract class Building {
  int level;
  bool isUpgrading;
  DateTime syncCompletionDate;

  Building({this.level, this.isUpgrading = false});

  void sync(Duration timeSinceLastSync);

  bool willCompleteUpgradeInSync(Duration timeSinceLastSync) {
    return isUpgrading && syncCompletionDate.isBefore(DateTime.now());
  }

  List<Duration> getDurationsBeforeAndAfterUpgrade(Duration timeSinceLastSync) {
    Duration postUpgradeDuration =
        DateTime.now().difference(syncCompletionDate);

    Duration preUpgradeDuration = timeSinceLastSync - postUpgradeDuration;

    return [preUpgradeDuration, postUpgradeDuration];
  }
}
