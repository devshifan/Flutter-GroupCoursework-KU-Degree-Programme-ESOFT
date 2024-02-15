import 'package:coursework_group/data/models/user.dart';
import 'package:coursework_group/data/services/user_service.dart';
import 'package:flutter/material.dart';

class FirstTimeUserCheckViewModel {
  Future<void> checkIfUserExists(BuildContext context) async {
    final UserService userService = UserService();
    final List<User> users = await userService.readUsers();
    print(
        '<------Print------> FirstTimeUserCheckViewModel - Number of users in the database: ${users.length}');

    // Check if there's any user with isActiveUser set to true
    final bool activeUserExists =
        users.any((user) => user.isActiveUser == true);

    if (activeUserExists) {
      // Navigate to the dashboard if an active user exists
      Navigator.of(context).pushReplacementNamed('/dashboard');
    } else {
      // Navigate to the login screen if no active user exists
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }
}
