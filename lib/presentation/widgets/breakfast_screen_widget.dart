import 'package:flutter/material.dart';
import 'package:coursework_group/data/models/meals_model.dart';
import 'package:provider/provider.dart';
import 'package:coursework_group/presentation/viewmodels/breakfast_screen_viewmodel.dart';

class BreakfastScreenWidget extends StatefulWidget {
  const BreakfastScreenWidget({Key? key}) : super(key: key);

  @override
  _BreakfastScreenWidgetState createState() => _BreakfastScreenWidgetState();
}

class _BreakfastScreenWidgetState extends State<BreakfastScreenWidget> {
  @override
  void initState() {
    super.initState();
    // Call loadBreakfastMeals in the initState
    Provider.of<BreakfastScreenViewModel>(context, listen: false)
        .loadBreakfastMeals();
  }

  @override
  Widget build(BuildContext context) {
    // Use Provider to access the view model
    var viewModel = Provider.of<BreakfastScreenViewModel>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Image.asset(
              'assets/images/bk2.jpg', // Add your illustration asset
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Breakfast Ideas',
            style: TextStyle(
              fontSize: 28.0,
              color: Colors.indigo,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          _buildMealList(viewModel.breakfastMeals),
        ],
      ),
    );
  }

  Widget _buildMealList(List<MealsModel> mealsList) {
    return Column(
      children: mealsList
          .expand((meal) => meal.breakfast.split(','))
          .map((food) => _buildMealCard(food.trim()))
          .toList(),
    );
  }

  Widget _buildMealCard(String food) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          title: Text(
            food,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
