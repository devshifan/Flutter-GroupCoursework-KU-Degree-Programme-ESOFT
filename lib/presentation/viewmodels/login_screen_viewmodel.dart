import 'package:coursework_group/data/models/user.dart';
import 'package:coursework_group/data/services/user_service.dart';
import 'package:coursework_group/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';

class LoginScreenViewModel {
  final UserService _userService = UserService();
  final UserProvider _userProvider = UserProvider();

  Future<User?> loginUser(String username, String password,
      Function(String) showMessage, BuildContext context) async {
    // try {
    //   print("login-controller : start");
    //   // Fetch user details from the database
    //   List<User> users = await _userService.readUsers();
    //   User? loginUser = users.firstWhere(
    //     (user) => user.username == username && user.password == password,
    //     orElse: () => User(
    //         id: 0, username: '', email: '', password: '', isActiveUser: false),
    //   );

    //   if (loginUser.isActiveUser!) {
    //     print("LoginScreenViewModel - users count : ${users.length}");

    //     print("LoginScreenViewModel - username : ${loginUser.username}");

    //     // Set the current active user in the provider
    //     _userProvider.setUser(loginUser.username!);

    //     Navigator.pushNamed(context, '/dashboard');
    //     return loginUser;
    //   } else {
    //     print("LoginScreenViewModel : error");
    //     showMessage("Invalid username or password");
    //     return null;
    //   }
    // } catch (e) {
    //   showMessage("Error during login: $e");
    //   rethrow;
    // }

    try {
      print("<------print------> login-controller : start");
      // Fetch user details from the database
      List<User> users = await _userService.readUsers();
      User? loginUser = users.firstWhere(
        (user) => user.username == username && user.password == password,
        orElse: () => User(
            id: 0, username: '', email: '', password: '', isActiveUser: false),
      );

      if (loginUser.isActiveUser!) {
        print(
            "<------print------>  LoginScreenViewModel - total users count : ${users.length}");

        print(
            "<------print------>  LoginScreenViewModel - logged username : ${loginUser.username}");
        print(
            "<------print------>  LoginScreenViewModel - logged email : ${loginUser.email}");

        // Set the current active user in the provider
        _userProvider.setUser(loginUser.username!);

        Navigator.pushNamed(context, '/dashboard');
        return loginUser;
      } else {
        print("LoginScreenViewModel : error");
        showMessage("Invalid username or password");
        return null;
      }
    } catch (e) {
      showMessage("Error during login: $e");
      rethrow;
    }
  }
}
