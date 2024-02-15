import 'package:coursework_group/presentation/viewmodels/welcome_screen_viewmodel.dart';
import 'package:coursework_group/presentation/widgets/welcome_screen_widget.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final WelcomeScreenViewModel viewModel = WelcomeScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return WelcomeScreenWidget(viewModel: WelcomeScreenViewModel());
  }
}
