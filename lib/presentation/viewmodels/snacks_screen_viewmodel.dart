// snacks_screen_viewmodel.dart

import 'package:coursework_group/data/models/meals_model.dart';
import 'package:coursework_group/data/models/profile_model.dart';
import 'package:coursework_group/data/models/user.dart';
import 'package:coursework_group/data/services/profile_service.dart';
import 'package:coursework_group/data/services/user_service.dart';
import 'package:coursework_group/utills/repositories/repository.dart';
import 'package:flutter/material.dart';

class SnacksScreenViewModel extends ChangeNotifier {
  List<MealsModel> _snacksMeals = [];
  List<MealsModel> get snacksMeals => _snacksMeals;

  final ProfileService _profileService = ProfileService();
  final Repository repository = Repository();

  Future<void> loadSnacksMeals() async {
    print("loadSnacksMeals");
    try {
      User? activeUser = await UserService().getCurrentActiveUser();

      if (activeUser != null) {
        print("loadSnacksMeals");
        String username = activeUser.username ?? "";

        ProfileModel userProfile =
            await _profileService.getProfileByUsername(username);

        String bmiCategory = userProfile.bmiCategory;

        _snacksMeals = await fetchSnacksMealsByCategory(bmiCategory);

        notifyListeners();
      }
    } catch (e) {
      print("Error loading snacks meals: $e");
    }
  }

  Future<List<MealsModel>> fetchSnacksMealsByCategory(
      String bmiCategory) async {
    try {
      List<Map<String, dynamic>> mealsData =
          await repository.getSnacksMealsByCategory(bmiCategory);

      // Convert the data to MealsModel objects
      List<MealsModel> mealsList =
          mealsData.map((map) => MealsModel.fromMap(map)).toList();
      print("success fetching snacks meals");

      return mealsList;
    } catch (e) {
      print("Error fetching snacks meals: $e");
      return [];
    }
  }
}
