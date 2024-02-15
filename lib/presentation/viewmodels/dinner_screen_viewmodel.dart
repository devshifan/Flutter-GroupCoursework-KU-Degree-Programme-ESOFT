import 'package:coursework_group/data/models/meals_model.dart';
import 'package:coursework_group/data/models/profile_model.dart';
import 'package:coursework_group/data/models/user.dart';
import 'package:coursework_group/data/services/profile_service.dart';
import 'package:coursework_group/data/services/user_service.dart';
import 'package:coursework_group/utills/repositories/repository.dart';
import 'package:flutter/material.dart';

class DinnerScreenViewModel extends ChangeNotifier {
  List<MealsModel> _dinnerMeals = [];
  List<MealsModel> get dinnerMeals => _dinnerMeals;

  final ProfileService _profileService = ProfileService();
  final Repository repository = Repository();

  Future<void> loadDinnerMeals() async {
    print("loadDinnerMeals");
    try {
      User? activeUser = await UserService().getCurrentActiveUser();

      if (activeUser != null) {
        print("loadDinnerMeals");
        String username = activeUser.username ?? "";

        ProfileModel userProfile =
            await _profileService.getProfileByUsername(username);

        String bmiCategory = userProfile.bmiCategory;

        _dinnerMeals = await fetchDinnerMealsByCategory(bmiCategory);

        notifyListeners();
      }
    } catch (e) {
      print("Error loading dinner meals: $e");
    }
  }

  Future<List<MealsModel>> fetchDinnerMealsByCategory(
      String bmiCategory) async {
    try {
      List<Map<String, dynamic>> mealsData =
          await repository.getDinnerMealsByCategory(bmiCategory);

      // Convert the data to MealsModel objects
      List<MealsModel> mealsList =
          mealsData.map((map) => MealsModel.fromMap(map)).toList();
      print("success fetching dinner meals");

      return mealsList;
    } catch (e) {
      print("Error fetching dinner meals: $e");
      return [];
    }
  }
}
