import 'package:coursework_group/presentation/widgets/dinner_screen_widget.dart';
import 'package:flutter/material.dart';

class DinnerScreen extends StatelessWidget {
  const DinnerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('FlexUp Dinner'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: DinnerScreenWidget(),
      ),
    );
  }
}
