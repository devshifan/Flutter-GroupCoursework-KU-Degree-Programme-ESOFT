// viewmodels/add_user_viewmodel.dart
import 'package:coursework_group/data/models/user.dart';
import 'package:coursework_group/data/services/user_service.dart';

class UserRegistrationViewModel {
  final UserService _userService = UserService();

  Future<void> saveUser(User user) async {
    // Implement the logic to save the user to the database
    await _userService.saveUser(user);
  }
}
