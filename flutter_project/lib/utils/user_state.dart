import 'package:flutter/material.dart';

class UserState extends ChangeNotifier {
  static final UserState _instance = UserState._internal();
  factory UserState() => _instance;
  UserState._internal();

  bool _isNewUser = false;

  bool get isNewUser => _isNewUser;

  void setUserType(bool isNewUser) {
    print('🔵 UserState: Setting isNewUser to $isNewUser'); // Debug
    _isNewUser = isNewUser;
    notifyListeners();
  }

  void resetUser() {
    print('🔴 UserState: Resetting user'); // Debug
    _isNewUser = false;
    notifyListeners();
  }
}