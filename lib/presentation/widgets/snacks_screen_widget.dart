import 'package:flutter/material.dart';
import 'package:coursework_group/data/models/meals_model.dart';
import 'package:provider/provider.dart';
import 'package:coursework_group/presentation/viewmodels/snacks_screen_viewmodel.dart';

class SnacksScreenWidget extends StatefulWidget {
  const SnacksScreenWidget({Key? key}) : super(key: key);

  @override
  _SnacksScreenWidgetState createState() => _SnacksScreenWidgetState();
}

class _SnacksScreenWidgetState extends State<SnacksScreenWidget> {
  @override
  void initState() {
    super.initState();
    // Call loadSnacksMeals in the initState
    Provider.of<SnacksScreenViewModel>(context, listen: false)
        .loadSnacksMeals();
  }

  @override
  Widget build(BuildContext context) {
    // Use Provider to access the view model
    var viewModel = Provider.of<SnacksScreenViewModel>(context);

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
                'assets/images/nuts.jpg', // Add your snacks image asset
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Snacks Recommended',
              style: TextStyle(
                fontSize: 28.0,
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: viewModel.snacksMeals
                    .expand((meal) => meal.snacks.split(','))
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
