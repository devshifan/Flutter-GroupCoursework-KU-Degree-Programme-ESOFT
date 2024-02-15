import 'package:flutter/material.dart';
import 'package:coursework_group/data/models/meals_model.dart';
import 'package:provider/provider.dart';
import 'package:coursework_group/presentation/viewmodels/lunch_screen_viewmodel.dart';

class LunchScreenWidget extends StatefulWidget {
  const LunchScreenWidget({Key? key}) : super(key: key);

  @override
  _LunchScreenWidgetState createState() => _LunchScreenWidgetState();
}

class _LunchScreenWidgetState extends State<LunchScreenWidget> {
  @override
  void initState() {
    super.initState();
    // Call loadLunchMeals in the initState
    Provider.of<LunchScreenViewModel>(context, listen: false).loadLunchMeals();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<LunchScreenViewModel>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/lunch.jpg', // Add your lunch image asset
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Lunch Ideas',
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: viewModel.lunchMeals
                    .expand((meal) => meal.lunch.split(','))
                    .map((food) => _buildMealCard(food.trim()))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealCard(String food) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        title: Text(
          food,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
