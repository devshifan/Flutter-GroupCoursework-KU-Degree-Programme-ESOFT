import 'package:flutter/material.dart';

class WorkoutScreenWidget extends StatefulWidget {
  const WorkoutScreenWidget({Key? key}) : super(key: key);

  @override
  _WorkoutScreenWidgetState createState() => _WorkoutScreenWidgetState();
}

class _WorkoutScreenWidgetState extends State<WorkoutScreenWidget> {
  // final WorkoutScreenViewModel viewModel = WorkoutScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Workout Plan',
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildWorkoutButton(
              'Upper Body',
              '/upperbody',
              'assets/images/upper.jpg',
              Colors.grey,
            ),
            _buildWorkoutButton(
              'Lower Body',
              '/lowerbody',
              'assets/images/lower.jpg',
              Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutButton(
    String text,
    String route,
    String imagePath,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(300, 60),
              primary: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
            ),
            onPressed: () {
              Navigator.pushNamed(context, route);
            },
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
