// DashboardScreenViewModel.dart
import 'package:coursework_group/data/models/profile_model.dart';
import 'package:coursework_group/data/services/profile_service.dart';
import 'package:coursework_group/presentation/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreenViewModel extends ChangeNotifier {
  final ProfileService _profileService = ProfileService();
  final UserProvider _userProvider = UserProvider();

  Map<String, dynamic> profileDetails = {};

  Future<void> loadProfileDashboardDetails() async {
    print("<------Print------> loadProfileDashboardDetails");

    try {
      String? store = _userProvider?.getUsername();
      print("<------Print------> loadProfileDashboardDetails store : ${store}");

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedUsername = prefs.getString('loggedInUsername');
      print(
          "<------Print------> loadProfileDashboardDetails SharedPreferences store : ${storedUsername}");

      if (storedUsername != null) {
        ProfileModel userProfile =
            await _profileService.getProfileByUsername(storedUsername);

        profileDetails = {
          'profilename': userProfile.profilename,
          'gender': userProfile.gender,
          'bmiCategory': userProfile.bmiCategory,
          'age': userProfile.age,
        };
        print(
            "<------Print------>  profileDetails profilename : ${userProfile.profilename}");
        print(
            "<------Print------>  profileDetails gender : ${userProfile.gender}");
        print(
            "<------Print------>  profileDetails bmiCategory : ${userProfile.bmiCategory}");
        print("<------Print------>  profileDetails age : ${userProfile.age}");

        notifyListeners();
      }
    } catch (e) {
      print("<------Print------> Error loadProfileDashboardDetails: $e");
    }
  }
}
