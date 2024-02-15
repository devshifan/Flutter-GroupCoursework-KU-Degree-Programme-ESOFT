import 'package:flutter/material.dart';

class UsernameProvider with ChangeNotifier {
  String? _loggedInUsername;

  String? get loggedInUsername => _loggedInUsername;

  void setLoggedInUsername(String? username) {
    _loggedInUsername = username;
    notifyListeners();
  }

  void clearLoggedInUsername() {
    _loggedInUsername = null;
    notifyListeners();
  }
}
