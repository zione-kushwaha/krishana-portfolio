import 'package:flutter/material.dart';

class CurrentTagNotifier extends ChangeNotifier {
  String _currentTag = '';

  String get currentTag => _currentTag;

  void setCurrentTag(String tag) {
    if (_currentTag != tag) {
      _currentTag = tag;
      notifyListeners();
    }
  }

  void clearTag() {
    _currentTag = '';
    notifyListeners();
  }
}
