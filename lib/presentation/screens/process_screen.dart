import 'package:coursework_group/presentation/widgets/process_screen_widget.dart';
import 'package:flutter/material.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({Key? key}) : super(key: key);

  @override
  _ProcessScreenState createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('FlexUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ProcessScreenWidget(),
      ),
    );
  }
}
