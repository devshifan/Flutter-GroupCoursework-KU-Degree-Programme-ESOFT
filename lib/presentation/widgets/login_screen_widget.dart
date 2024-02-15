import 'package:coursework_group/presentation/providers/userame_provider.dart';
import 'package:flutter/material.dart';
import 'package:coursework_group/presentation/viewmodels/login_screen_viewmodel.dart';
import 'package:coursework_group/data/models/user.dart';
import 'package:coursework_group/data/services/user_service.dart';
import 'package:coursework_group/presentation/providers/user_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenWidget extends StatelessWidget {
  final LoginScreenViewModel viewModel = LoginScreenViewModel();
  final UserService _userService = UserService();
  final UserProvider _userProvider = UserProvider();
  final UsernameProvider _usernameProvider = UsernameProvider();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(),
            _inputField(context),
            _signup(context),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.only(top: 40), // Add some top padding
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/login.jpg', // Replace with the path to your image
              width: 300,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              "Welcome Back",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("Enter your credentials to login"),
          ],
        ),
      ),
    );
  }

  Widget _inputField(BuildContext context) {
    String? errorMessage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.person),
            errorText: errorMessage,
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.lock),
            errorText: errorMessage,
          ),
          obscureText: true,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: Size(360, 40)),
          onPressed: () async {
            // Modify the logic to set errorMessage based on conditions
            errorMessage =
                "Your custom error message"; // Set the desired error message
            await loginUser(context);
          },
          child: const Text('Login'),
        ),
      ],
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account? "),
        TextButton(
          onPressed: () async {
            Navigator.pushNamed(context, '/signup');
          },
          child: Text("Sign Up"),
        ),
      ],
    );
  }

  Future<void> loginUser(BuildContext context) async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      User? loggedInUser = await viewModel.loginUser(
        username,
        password,
        (message) => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            duration: Duration(seconds: 2),
          ),
        ),
        context,
      );

      if (loggedInUser != null) {
        // Save the username to shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('loggedInUsername', loggedInUser.username ?? ''); //

        print('User logged in test: ${loggedInUser.username}');
        _usernameProvider.setLoggedInUsername(loggedInUser.username);

        // Retrieve and print the value from the provider
        String? usernameFromProvider = _usernameProvider.loggedInUsername;
        print('Username from Provider: $usernameFromProvider');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username and password are required.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
