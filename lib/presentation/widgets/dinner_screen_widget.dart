import 'package:flutter/material.dart';
import 'package:coursework_group/data/models/meals_model.dart';
import 'package:provider/provider.dart';
import 'package:coursework_group/presentation/viewmodels/dinner_screen_viewmodel.dart';

class DinnerScreenWidget extends StatefulWidget {
  const DinnerScreenWidget({Key? key}) : super(key: key);

  @override
  _DinnerScreenWidgetState createState() => _DinnerScreenWidgetState();
}

class _DinnerScreenWidgetState extends State<DinnerScreenWidget> {
  @override
  void initState() {
    super.initState();
    // Call loadDinnerMeals in the initState
    Provider.of<DinnerScreenViewModel>(context, listen: false)
        .loadDinnerMeals();
  }

  @override
  Widget build(BuildContext context) {
    // Use Provider to access the view model
    var viewModel = Provider.of<DinnerScreenViewModel>(context);

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
                'assets/images/dinner.jpg', // Add your dinner image asset
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Dinner Recommended',
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: viewModel.dinnerMeals
                    .expand((meal) => meal.dinner.split(','))
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
