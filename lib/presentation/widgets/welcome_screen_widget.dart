import 'package:coursework_group/presentation/screens/user_registration_screen.dart';
import 'package:coursework_group/presentation/viewmodels/welcome_screen_viewmodel.dart';
import 'package:flutter/material.dart';

class WelcomeScreenWidget extends StatelessWidget {
  final WelcomeScreenViewModel viewModel;

  WelcomeScreenWidget({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 500,
              height: 400,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  'assets/images/logo2.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'FlexUp',
                style: TextStyle(
                  fontSize: 36.0,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
              child: ElevatedButton(
                onPressed: () async {
                  // Navigate to UserRegistrationScreen using named route
                  Navigator.pushNamed(context, '/userCheck');
                },
                child: Text('Welcome'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
