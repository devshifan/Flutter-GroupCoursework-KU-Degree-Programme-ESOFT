// snacks_screen.dart

import 'package:coursework_group/presentation/widgets/snacks_screen_widget.dart';
import 'package:flutter/material.dart';

class SnacksScreen extends StatelessWidget {
  const SnacksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('FlexUp Snacks'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SnacksScreenWidget(),
      ),
    );
  }
}
