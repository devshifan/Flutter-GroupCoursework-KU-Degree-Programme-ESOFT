import 'package:coursework_group/data/models/user.dart';
import 'package:coursework_group/data/services/user_service.dart';
import 'package:flutter/material.dart';

class SignupScreenViewModel with ChangeNotifier {
  final UserService _userService = UserService();

  Future<void> signUpUser(String username, String email, String password,
      Function(String) showMessage) async {
    try {
      // Check if a user with the same username or email already exists
      List<User> users = await _userService.readUsers();
      bool userExists =
          users.any((user) => user.username == username || user.email == email);

      if (userExists) {
        // If user already exists, show an error message
        showMessage("User with the same username or email already exists");
      } else {
        // If user doesn't exist, proceed with registration
        User newUser = User(
            username: username,
            email: email,
            password: password,
            isActiveUser: true);

        // Save the new user to the database
        await _userService.saveUser(newUser);
        showMessage("User registration successful");

        notifyListeners();
      }
    } catch (e) {
      showMessage("Error during user registration: $e");
      rethrow;
    }
  }
}
