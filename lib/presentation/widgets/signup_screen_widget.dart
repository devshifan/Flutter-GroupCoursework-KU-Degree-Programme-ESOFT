import 'package:coursework_group/presentation/viewmodels/signup_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreenWidget extends StatefulWidget {
  const SignupScreenWidget({Key? key}) : super(key: key);

  @override
  _SignupScreenWidgetState createState() => _SignupScreenWidgetState();
}

class _SignupScreenWidgetState extends State<SignupScreenWidget> {
  final SignupScreenViewModel viewModel = SignupScreenViewModel();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();

  String usernameError = '';
  String emailError = '';
  String passwordError = '';
  String retypePasswordError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(context),
            _inputFields(context),
            _loginInfo(context),
          ],
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        SizedBox(height: 40), // Adjust spacing from the top
        Image.asset(
          'assets/images/signupp.jpg', // Replace with the path to your image
          width: 180,
          height: 180,
          fit: BoxFit.cover,
        ),
        Text(
          "Create Account",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text("Enter details to get started"),
      ],
    );
  }

  _inputFields(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: usernameController,
          decoration: InputDecoration(
            hintText: "Username",
            errorText: usernameError.isNotEmpty ? usernameError : null,
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color:
                    usernameError.isNotEmpty ? Colors.red : Colors.transparent,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Email id",
            errorText: emailError.isNotEmpty ? emailError : null,
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.email_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: emailError.isNotEmpty ? Colors.red : Colors.transparent,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            errorText: passwordError.isNotEmpty ? passwordError : null,
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.password_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color:
                    passwordError.isNotEmpty ? Colors.red : Colors.transparent,
              ),
            ),
          ),
          obscureText: true,
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: retypePasswordController,
          decoration: InputDecoration(
            hintText: "Retype Password",
            errorText:
                retypePasswordError.isNotEmpty ? retypePasswordError : null,
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.password_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                color: retypePasswordError.isNotEmpty
                    ? Colors.red
                    : Colors.transparent,
              ),
            ),
          ),
          obscureText: true,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 360,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              _onSignUpButtonPressed();
            },
            child: const Text('Sign Up'),
          ),
        ),
      ],
    );
  }

  _loginInfo(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account?"),
        TextButton(
          onPressed: () async {
            // Navigate to UserRegistrationScreen using named route
            Navigator.pushNamed(context, '/login');
          },
          child: Text("Login"),
        ),
      ],
    );
  }

  void _onSignUpButtonPressed() async {
    // Validate the entered values
    if (!_validateInputs()) {
      return; // Do not proceed with registration if validation fails
    }

    // Check if passwords match
    if (passwordController.text != retypePasswordController.text) {
      setState(() {
        retypePasswordError = 'Passwords do not match';
      });
      return;
    }

    try {
      await viewModel.signUpUser(
        usernameController.text,
        emailController.text,
        passwordController.text,
        (String message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          );
        },
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('loggedInUsername', usernameController.text ?? ''); //

      // After successful user registration, navigate to the profile route
      Navigator.pushReplacementNamed(context, '/profile');
    } catch (e) {
      // Handle errors (if needed)
      print("<------Print------> Error during user registration: $e");
    }
  }

  // Validate input values
  bool _validateInputs() {
    // Reset previous error messages
    setState(() {
      usernameError = '';
      emailError = '';
      passwordError = '';
      retypePasswordError = '';
    });

    bool isValid = true;

    if (usernameController.text.isEmpty) {
      setState(() {
        usernameError = 'Username is required';
      });
      isValid = false;
    }

    if (emailController.text.isEmpty) {
      setState(() {
        emailError = 'Email is required';
      });
      isValid = false;
    }

    if (passwordController.text.isEmpty) {
      setState(() {
        passwordError = 'Password is required';
      });
      isValid = false;
    }

    // You can add more specific validation checks here if needed

    return isValid;
  }
}
