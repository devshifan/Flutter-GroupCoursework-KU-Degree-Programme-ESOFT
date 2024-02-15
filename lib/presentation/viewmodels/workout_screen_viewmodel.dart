import 'package:coursework_group/data/models/meals_model.dart';
import 'package:coursework_group/data/models/profile_model.dart';
import 'package:coursework_group/data/models/user.dart';
import 'package:coursework_group/data/models/workout_model.dart';
import 'package:coursework_group/data/services/profile_service.dart';
import 'package:coursework_group/data/services/user_service.dart';
import 'package:coursework_group/utills/repositories/repository.dart';
import 'package:flutter/material.dart';

class WorkoutScreenViewModel extends ChangeNotifier {
  List<WorkoutModel> _workoutList = [];
  List<WorkoutModel> get workouts => _workoutList;

  final ProfileService _profileService = ProfileService();
  final Repository repository = Repository();

  Future<void> loadWorkout() async {
    print("loadWorkout");
    try {
      User? activeUser = await UserService().getCurrentActiveUser();

      if (activeUser != null) {
        print("loadWorkout");
        String username = activeUser.username ?? "";

        ProfileModel userProfile =
            await _profileService.getProfileByUsername(username);

        String bmiCategory = userProfile.bmiCategory;
        String gender = userProfile.bmiCategory;

        _workoutList =
            await fetchWorkoutsByCategoryAndGender(bmiCategory, gender);

        notifyListeners();
      }
    } catch (e) {
      print("Error loading Workout: $e");
    }
  }

  Future<List<WorkoutModel>> fetchWorkoutsByCategoryAndGender(
      String bmiCategory, String gender) async {
    try {
      List<Map<String, dynamic>> mealsData =
          await repository.getBreakfastMealsByCategory(bmiCategory);

      List<WorkoutModel> workoutList =
          mealsData.map((map) => WorkoutModel.fromMap(map)).toList();
      print("success fetching Workout");

      return workoutList;
    } catch (e) {
      print("Error fetching Workout: $e");
      return [];
    }
  }

  // Future<void> loadBreakfastMeals() async {
  //   print("loadBreakfastMeals");
  //   try {
  //     User? activeUser = await UserService().getCurrentActiveUser();

  //     if (activeUser != null) {
  //       print("loadBreakfastMeals");
  //       String username = activeUser.username ?? "";

  //       ProfileModel userProfile =
  //           await _profileService.getProfileByUsername(username);

  //       String bmiCategory = userProfile.bmiCategory;

  //       _breakfastMeals = await fetchBreakfastMealsByCategory(bmiCategory);

  //       notifyListeners();
  //     }
  //   } catch (e) {
  //     print("Error loading breakfast meals: $e");
  //   }
  // }

  // Future<List<MealsModel>> fetchBreakfastMealsByCategory(
  //     String bmiCategory) async {
  //   try {
  //     List<Map<String, dynamic>> mealsData =
  //         await repository.getBreakfastMealsByCategory(bmiCategory);

  //     // Convert the data to MealsModel objects
  //     List<MealsModel> mealsList =
  //         mealsData.map((map) => MealsModel.fromMap(map)).toList();
  //     print("success fetching breakfast meals");

  //     return mealsList;
  //   } catch (e) {
  //     print("Error fetching breakfast meals: $e");
  //     return [];
  //   }
  // }
}
