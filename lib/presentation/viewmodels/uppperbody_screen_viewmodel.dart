import 'package:coursework_group/data/models/profile_model.dart';
import 'package:coursework_group/data/models/user.dart';
import 'package:coursework_group/data/models/workout_model.dart';
import 'package:coursework_group/data/services/profile_service.dart';
import 'package:coursework_group/data/services/user_service.dart';
import 'package:coursework_group/utills/repositories/repository.dart';
import 'package:flutter/material.dart';

class UpperbodyScreenViewModel extends ChangeNotifier {
  List<WorkoutModel> _upperBodyWorkouts = [];
  List<WorkoutModel> get upperBodyWorkout => _upperBodyWorkouts;

  final ProfileService _profileService = ProfileService();
  final Repository repository = Repository();

  Future<List<WorkoutModel>> loadWorkouts() async {
    try {
      User? activeUser = await UserService().getCurrentActiveUser();

      if (activeUser != null) {
        String username = activeUser.username ?? "";

        ProfileModel userProfile =
            await _profileService.getProfileByUsername(username);

        String bmiCategory = userProfile.bmiCategory;
        String gender = userProfile.gender;
        print("bmiCategory data: $bmiCategory");
        print("gender data: $gender");
        _upperBodyWorkouts = await fetchUpperbodyWorkouts(bmiCategory, gender);

        print(
            "Fetched workouts: $_upperBodyWorkouts"); // Add this line for debugging

        notifyListeners();
        return _upperBodyWorkouts;
      }

      return [];
    } catch (e) {
      print("Error loading workouts: $e");
      throw e;
    }
  }

  Future<List<WorkoutModel>> fetchUpperbodyWorkouts(
      String bmiCategory, String gender) async {
    try {
      List<Map<String, dynamic>> workoutData =
          await repository.getWorkoutsByGenderByCategory(bmiCategory, gender);

      Map<String, dynamic>? workout = await repository.getWorkoutById(6);

      List<Map<String, dynamic>> workoutsByCate =
          await repository.getWorkoutsByCategory('normalWeight');

      print("workoutsByCate: $workoutsByCate");
      print("Workoutdata: $workoutData");
      print("Workout: $workout");

      List<WorkoutModel> workoutList =
          workoutData.map((map) => WorkoutModel.fromMap(map)).toList();

      return workoutList;
    } catch (e) {
      print("Error fetching workoutList: $e");
      throw e;
    }
  }
}
