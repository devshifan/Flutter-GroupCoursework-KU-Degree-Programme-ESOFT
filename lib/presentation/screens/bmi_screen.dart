import 'package:coursework_group/presentation/widgets/bmi_screen_widget.dart';
import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('FlexUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BmiScreenWidget(),
      ),
    );
  }
}
