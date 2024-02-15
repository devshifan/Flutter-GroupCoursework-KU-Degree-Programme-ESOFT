import 'package:coursework_group/presentation/widgets/breakfast_screen_widget.dart';
import 'package:coursework_group/presentation/widgets/lowerbody_screen_widget.dart';
import 'package:coursework_group/presentation/widgets/upperbody_screen_widget.dart';
import 'package:flutter/material.dart';

class LowerbodyScreen extends StatelessWidget {
  const LowerbodyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('FlexUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: LowerbodyScreenWidget(),
      ),
    );
  }
}
