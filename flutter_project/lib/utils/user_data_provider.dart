import 'dart:typed_data';
import 'package:flutter/material.dart';

class UserDataProvider extends ChangeNotifier {
  String _name = 'User';
  String _location = 'Your Location';
  String _skills = 'Your Skills';
  String _profileImagePath = '';
  Uint8List? _profileImageBytes; // ✅ NEW: Store image bytes for web

  String get name => _name;
  String get location => _location;
  String get skills => _skills;
  String get profileImagePath => _profileImagePath;
  Uint8List? get profileImageBytes => _profileImageBytes; // ✅ NEW

  void updateUserData({
    required String name,
    required String location,
    required String skills,
    String? profileImagePath,
    Uint8List? profileImageBytes, // ✅ NEW
  }) {
    _name = name;
    _location = location;
    _skills = skills;
    if (profileImagePath != null) {
      _profileImagePath = profileImagePath;
    }
    if (profileImageBytes != null) {
      _profileImageBytes = profileImageBytes;
    }
    notifyListeners();
  }

  void resetUserData() {
    _name = 'User';
    _location = 'Your Location';
    _skills = 'Your Skills';
    _profileImagePath = '';
    _profileImageBytes = null; // ✅ NEW
    notifyListeners();
  }

  void setDemoUser() {
    _name = 'Demo User';
    _location = 'Demo Location';
    _skills = 'Flutter, Firebase';
    _profileImagePath = '';
    _profileImageBytes = null; // ✅ NEW
    notifyListeners();
  }
}
