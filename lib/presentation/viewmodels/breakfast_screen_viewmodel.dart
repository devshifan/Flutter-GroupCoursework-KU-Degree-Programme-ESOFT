import 'package:coursework_group/data/models/meals_model.dart';
import 'package:coursework_group/data/models/profile_model.dart';
import 'package:coursework_group/data/models/user.dart';
import 'package:coursework_group/data/services/profile_service.dart';
import 'package:coursework_group/data/services/user_service.dart';
import 'package:coursework_group/utills/repositories/repository.dart';
import 'package:flutter/material.dart';

class BreakfastScreenViewModel extends ChangeNotifier {
  List<MealsModel> _breakfastMeals = [];
  List<MealsModel> get breakfastMeals => _breakfastMeals;

  final ProfileService _profileService = ProfileService();
  final Repository repository = Repository();

  Future<void> loadBreakfastMeals() async {
    print("loadBreakfastMeals");
    try {
      User? activeUser = await UserService().getCurrentActiveUser();

      if (activeUser != null) {
        print("loadBreakfastMeals");
        String username = activeUser.username ?? "";

        ProfileModel userProfile =
            await _profileService.getProfileByUsername(username);

        String bmiCategory = userProfile.bmiCategory;

        _breakfastMeals = await fetchBreakfastMealsByCategory(bmiCategory);

        notifyListeners();
      }
    } catch (e) {
      print("Error loading breakfast meals: $e");
    }
  }

  Future<List<MealsModel>> fetchBreakfastMealsByCategory(
      String bmiCategory) async {
    try {
      List<Map<String, dynamic>> mealsData =
          await repository.getBreakfastMealsByCategory(bmiCategory);

      // Convert the data to MealsModel objects
      List<MealsModel> mealsList =
          mealsData.map((map) => MealsModel.fromMap(map)).toList();
      print("success fetching breakfast meals");

      return mealsList;
    } catch (e) {
      print("Error fetching breakfast meals: $e");
      return [];
    }
  }
}
