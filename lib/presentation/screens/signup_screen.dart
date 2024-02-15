import 'package:coursework_group/presentation/widgets/signup_screen_widget.dart';
import 'package:coursework_group/presentation/viewmodels/signup_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Flexup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ChangeNotifierProvider(
          create: (_) => SignupScreenViewModel(),
          child: Consumer<SignupScreenViewModel>(
            builder: (context, viewModel, _) => SignupScreenWidget(),
          ),
        ),
      ),
    );
  }
}
