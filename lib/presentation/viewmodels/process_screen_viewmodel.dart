import 'package:coursework_group/data/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:coursework_group/data/models/bmi_model.dart';
import 'package:coursework_group/data/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProcessScreenViewModel with ChangeNotifier {
  double _bmi = 0.0;
  BMICategory _bmiCategory = BMICategory.normalWeight;

  double get bmi => _bmi;
  BMICategory get bmiCategory => _bmiCategory;

  void calculateAndSetBMI(double height, double weight) {
    _bmi = _calculateBMI(height, weight);
    _bmiCategory = categorizeBMI(_bmi);
    notifyListeners();
  }

  Future<void> updateProfileTable(
      String name, int age, String gender, BMICategory bmiCategory) async {
    try {
      print("<-------print-------> updateProfileTable : ");
      // Assuming you have a UserService instance
      UserService userService = UserService();

      // Get the current active user
      User? activeUser = await userService.getCurrentActiveUser();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? storedUsername = prefs.getString('loggedInUsername');
      print(
          "<------Print------> loadProfileDashboardDetails SharedPreferences store : ${storedUsername}");

      print(
          "<-------print-------> updateProfileTable activeUser : ${activeUser}");
      print(
          "<-------print-------> updateProfileTable username : ${activeUser?.username}");
      print("<-------print-------> updateProfileTable age : ${age}");
      print("<-------print-------> updateProfileTable gender : ${gender}");
      print(
          "<-------print-------> updateProfileTable bmiCategory : ${bmiCategory.toString().split('.').last}");

      // Update or insert the user's profile information
      await userService.updateUserProfile(
        storedUsername ?? '', // Use the username of the active user
        name ?? '', // Use the username of the active user
        bmiCategory.toString().split('.').last, // Convert enum to string
        age,
        gender,
      );
      print("update success : ");
    } catch (e) {
      print("Error updating profile table: $e");
      // Handle the error as needed
    }
  }

  double _calculateBMI(double height, double weight) {
    return weight / ((height / 100) * (height / 100));
  }
}
