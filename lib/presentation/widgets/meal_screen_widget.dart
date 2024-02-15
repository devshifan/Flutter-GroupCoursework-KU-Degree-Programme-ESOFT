import 'package:flutter/material.dart';

class MealScreenWidget extends StatefulWidget {
  const MealScreenWidget({Key? key}) : super(key: key);

  @override
  _MealScreenWidgetState createState() => _MealScreenWidgetState();
}

class _MealScreenWidgetState extends State<MealScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/foodplan.jpg', // Add your image asset path
                height: 150, // Adjust the height as needed
              ),
              SizedBox(height: 20),
              Text(
                'Meal Plan',
                style: TextStyle(
                  fontSize: 36.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              _buildMealButton('Breakfast', '/breakfast', Colors.teal.shade300),
              _buildMealButton('Lunch', '/lunch', Colors.amber.shade300),
              _buildMealButton('Snacks', '/snacks', Colors.orange.shade300),
              _buildMealButton('Dinner', '/dinner', Colors.deepOrange.shade300),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMealButton(String text, String route, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: SizedBox(
        width: 200, // Adjust the width as needed
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20),
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
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
