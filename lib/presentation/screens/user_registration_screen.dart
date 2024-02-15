// screens/user_registration_screen.dart
import 'package:coursework_group/data/models/user.dart';
import 'package:coursework_group/presentation/viewmodels/user_registration_viewmodel.dart';
import 'package:coursework_group/presentation/widgets/user_registration_form_widget.dart';
import 'package:flutter/material.dart';

class UserRegistrationScreen extends StatelessWidget {
  final UserRegistrationViewModel viewModel = UserRegistrationViewModel();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: UserRegistrationFormWidget(
        usernameController: usernameController,
        passwordController: passwordController,
        onPressed: () async {
          // Retrieve the entered data
          String username = usernameController.text.trim();
          String password = passwordController.text.trim();

          // Create a User object
          User newUser = User(username: username, password: password);

          // Call the view model method to save the user
          await viewModel.saveUser(newUser);

          // Navigate to the welcome screen with the logged-in username
          Navigator.pushReplacementNamed(
            context,
            '/welcome',
            arguments: {'username': username},
          );
        },
      ),
    );
  }
}
