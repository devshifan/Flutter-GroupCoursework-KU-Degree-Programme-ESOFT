import 'package:coursework_group/presentation/widgets/meal_screen_widget.dart';
import 'package:flutter/material.dart';

class MealScreen extends StatefulWidget {
  const MealScreen({Key? key}) : super(key: key);

  @override
  _MealScreenState createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('FlexUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: MealScreenWidget(),
      ),
    );
  }
}
