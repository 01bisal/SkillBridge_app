import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  String _name = 'User';
  String _location = 'Your Location';
  String _skills = 'Your Skills';

  String get name => _name;
  String get location => _location;
  String get skills => _skills;

  void updateUserData({
    required String name,
    required String location,
    required String skills,
  }) {
    _name = name;
    _location = location;
    _skills = skills;
    notifyListeners();
  }

  void resetUserData() {
    _name = 'User';
    _location = 'Your Location';
    _skills = 'Your Skills';
    notifyListeners();
  }
}