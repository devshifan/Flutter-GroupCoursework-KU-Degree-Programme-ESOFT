// lunch_screen_viewmodel.dart

import 'package:coursework_group/data/models/meals_model.dart';
import 'package:coursework_group/data/models/profile_model.dart';
import 'package:coursework_group/data/models/user.dart';
import 'package:coursework_group/data/services/profile_service.dart';
import 'package:coursework_group/data/services/user_service.dart';
import 'package:coursework_group/utills/repositories/repository.dart';
import 'package:flutter/material.dart';

class LunchScreenViewModel extends ChangeNotifier {
  List<MealsModel> _lunchMeals = [];
  List<MealsModel> get lunchMeals => _lunchMeals;

  final ProfileService _profileService = ProfileService();
  final Repository repository = Repository();

  Future<void> loadLunchMeals() async {
    try {
      User? activeUser = await UserService().getCurrentActiveUser();

      if (activeUser != null) {
        String username = activeUser.username ?? "";

        ProfileModel userProfile =
            await _profileService.getProfileByUsername(username);

        String bmiCategory = userProfile.bmiCategory;

        _lunchMeals = await fetchLunchMealsByCategory(bmiCategory);

        notifyListeners();
      }
    } catch (e) {
      print("Error loading lunch meals: $e");
    }
  }

  Future<List<MealsModel>> fetchLunchMealsByCategory(String bmiCategory) async {
    try {
      List<Map<String, dynamic>> mealsData =
          await repository.getLunchMealsByCategory(bmiCategory);

      List<MealsModel> mealsList =
          mealsData.map((map) => MealsModel.fromMap(map)).toList();

      return mealsList;
    } catch (e) {
      print("Error fetching lunch meals: $e");
      return [];
    }
  }
}
