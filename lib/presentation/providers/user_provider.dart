import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? username;

  void setUser(String username) {
    this.username = username;
    notifyListeners();
  }

  String? getUsername() {
    return username;
  }
}
