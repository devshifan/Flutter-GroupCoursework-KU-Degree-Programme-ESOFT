import 'package:coursework_group/data/models/profile_model.dart';
import 'package:coursework_group/data/models/user.dart';
import 'package:coursework_group/data/services/user_service.dart';
import 'package:coursework_group/utills/repositories/repository.dart';

class ProfileService {
  final Repository _repository = Repository();
  final UserService _userService = UserService();
  Future<ProfileModel> getProfileByUsername(String username) async {
    try {
      List<User> users = await _userService.readUsers();
      print(" getProfileByUsername _userService: $users");

      for (var user in users) {
        print(
            "  ${user.username} - ${user.email}"); // Print each user's username and email
      }

      List<ProfileModel> profils = await _userService.readProfiles();
      print(" getProfileByUsername _userService: $profils");

      for (var profil in profils) {
        print(
            "  ${profil.username} - ${profil.age}- ${profil.gender}- ${profil.bmiCategory}"); // Print each user's username and email
      }

      print(" getProfileByUsername username: $username");
      var profileData = await _repository.readDataWithWhere('profile',
          where: 'username = ?', whereArgs: [username]);
      print(" getProfileByUsername profileData: $profileData");

      if (profileData != null && profileData.isNotEmpty) {
        return ProfileModel.fromMap(profileData.first);
      } else {
        // Handle the case where the profile is not found
        throw Exception('Profile not found for username: $username');
      }
    } catch (e) {
      print("Error getting profile: $e");
      rethrow;
    }
  }
}
