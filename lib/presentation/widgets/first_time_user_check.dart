import 'package:coursework_group/presentation/viewmodels/first_time_user_check_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class FirstTimeUserCheck extends StatefulWidget {
  @override
  _FirstTimeUserCheckState createState() => _FirstTimeUserCheckState();
}

class _FirstTimeUserCheckState extends State<FirstTimeUserCheck> {
  final FirstTimeUserCheckViewModel viewModel = FirstTimeUserCheckViewModel();

  @override
  void initState() {
    super.initState();
    // Consider using a Future.delayed here for a smoother transition
    Future.delayed(Duration(seconds: 2), () {
      viewModel.checkIfUserExists(context); // Pass context to the method
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitChasingDots(
              // You can choose a different Spinkit animation
              color: Theme.of(context)
                  .primaryColor, // Use your app's primary color
              size: 50.0,
            ),
            SizedBox(height: 16.0),
            Text(
              'Checking for existing users...',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
