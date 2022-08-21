import 'package:flutter/material.dart';

class NarratorController extends ChangeNotifier {
  int _explorationCompletedCount = 0;
  bool _explorationStarted = false;
  bool _enableMerge = false;

  int get explorationCompletedCount => _explorationCompletedCount;
  bool get explorationStarted => _explorationStarted;
  bool get enableMerge => _enableMerge;

  set enableMerge(bool value) {
    _enableMerge = value;
    notifyListeners();
  }

  void reset() {
    _explorationCompletedCount = 0;
    _explorationStarted = false;
    _enableMerge = false;
    notifyListeners();
  }

  void setExplorationStarted({bool value = true}) {
    _explorationStarted = value;
    _explorationCompletedCount = 0;
    notifyListeners();
  }

  void incrementExplorationCount() {
    _explorationCompletedCount += 1;
    notifyListeners();
  }
}
