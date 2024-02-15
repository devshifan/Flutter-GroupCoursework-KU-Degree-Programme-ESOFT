import 'package:coursework_group/data/models/workout_model.dart';
import 'package:coursework_group/presentation/viewmodels/lowerbody_screen_viewmodel.dart';
import 'package:coursework_group/presentation/viewmodels/uppperbody_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LowerbodyScreenWidget extends StatefulWidget {
  const LowerbodyScreenWidget({Key? key}) : super(key: key);

  @override
  _LowerbodyScreenWidgetState createState() => _LowerbodyScreenWidgetState();
}

class _LowerbodyScreenWidgetState extends State<LowerbodyScreenWidget> {
  late Future<List<WorkoutModel>> _loadWorkoutsFuture;

  @override
  void initState() {
    super.initState();
    _loadWorkoutsFuture = _loadWorkouts();
  }

  Future<List<WorkoutModel>> _loadWorkouts() async {
    // Use Provider to access the view model
    var viewModel =
        Provider.of<LowerbodyScreenViewModel>(context, listen: false);

    try {
      return await viewModel.loadWorkouts();
    } catch (e) {
      // Handle the error or return an empty list as needed
      print("Error loading workouts: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<WorkoutModel>>(
      future: _loadWorkoutsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No workouts available.');
        } else {
          List<WorkoutModel> workoutList = snapshot.data!;
          return Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'LowerBody Workouts',
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _buildWorkoutList(workoutList),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buildWorkoutList(List<WorkoutModel> workoutList) {
    return Column(
      children: workoutList
          .expand((workout) => workout.lowerbody.split(','))
          .map((food) => _buildWorkoutCard(food.trim()))
          .toList(),
    );
  }

  Widget _buildWorkoutCard(String workout) {
    // Split the workout string into category and times
    List<String> workoutParts = workout.split('(');

    // Extract category and times
    String category = workoutParts[0].trim();
    String times = workoutParts[1].replaceAll(')', '').trim();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Category: $category',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Times: $times',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
