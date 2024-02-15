import 'package:coursework_group/presentation/widgets/workout_screen_widget.dart';
import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('FlexUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: WorkoutScreenWidget(),
      ),
    );
  }
}
