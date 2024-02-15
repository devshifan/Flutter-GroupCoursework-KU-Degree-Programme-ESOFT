import 'package:coursework_group/presentation/providers/user_provider.dart';
import 'package:coursework_group/presentation/widgets/dashboard_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('FlexUp'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: DashboardScreenWidget(),
      ),
    );
  }
}
