// viewmodels/add_user_viewmodel.dart
import 'package:coursework_group/data/models/user.dart';
import 'package:coursework_group/data/services/user_service.dart';

class WelcomeScreenViewModel {
  final UserService _userService = UserService();
  bool _isFinished = false;
  bool get isFinished => _isFinished;

  void setFinished(bool value) {
    _isFinished = value;
  }

  Future<void> retriveUser() async {
    await _userService.readUsers();
    print('retrived users: ${_userService.readUsers()}');
  }

  Future<String?> showUserExists() async {
    final List<User> users = await _userService.readUsers();
    print('Number of users in the database: ${users.length}');

    if (users.isNotEmpty) {
      User myUser = users[0];
      print('User found: ${myUser.username}');
      // You can perform additional actions with the user data here if needed
      return myUser.username;
    } else {
      print('No users found. Returning as guest.');
      return null; // Return null for the 'Guest' case
    }
  }
}
