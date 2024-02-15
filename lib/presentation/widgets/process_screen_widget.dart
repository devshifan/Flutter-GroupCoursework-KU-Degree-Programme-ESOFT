// lib/presentation/widgets/process_screen_widget.dart

import 'package:coursework_group/presentation/viewmodels/bmi_screen_viewmodel.dart';
import 'package:coursework_group/presentation/viewmodels/process_screen_viewmodel.dart';
import 'package:coursework_group/presentation/viewmodels/profile_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ProcessScreenWidget extends StatefulWidget {
  const ProcessScreenWidget({Key? key}) : super(key: key);

  @override
  _ProcessScreenWidgetState createState() => _ProcessScreenWidgetState();
}

class _ProcessScreenWidgetState extends State<ProcessScreenWidget> {
  late ProcessScreenViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = Provider.of<ProcessScreenViewModel>(context, listen: false);
  }

  // Utility function to mimic describeEnum
  String enumToString(dynamic value) {
    return value.toString().split('.').last;
  }

  @override
  Widget build(BuildContext context) {
    // Access the ProfileScreenViewModel
    final profileViewModel =
        Provider.of<ProfileScreenViewModel>(context, listen: false);

    // Access the BmiScreenViewModel
    final bmiViewModel =
        Provider.of<BmiScreenViewModel>(context, listen: false);

    // Calculate BMI and update ViewModel
    viewModel.calculateAndSetBMI(
        bmiViewModel.height, bmiViewModel.currentWeight);
    print("aaaaa : ");

    // Update profile table with BMI
    viewModel.updateProfileTable(
      profileViewModel.name,
      profileViewModel.age,
      profileViewModel.gender == 1 ? 'Male' : 'Female',
      viewModel.bmiCategory,
    );

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Process Plans',
              style: TextStyle(
                fontSize: 36.0,
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: Container(
              child: SfRadialGauge(
                enableLoadingAnimation: true,
                animationDuration: 4500,
                axes: <RadialAxis>[
                  RadialAxis(
                    minimum: 0,
                    maximum: 100,
                    ranges: <GaugeRange>[
                      GaugeRange(
                        startValue: 0,
                        endValue: 50,
                        color: Colors.green,
                        startWidth: 10,
                        endWidth: 10,
                      ),
                      GaugeRange(
                        startValue: 50,
                        endValue: 100,
                        color: Colors.orange,
                        startWidth: 10,
                        endWidth: 10,
                      ),
                      GaugeRange(
                        startValue: 100,
                        endValue: 150,
                        color: Colors.red,
                        startWidth: 10,
                        endWidth: 10,
                      ),
                    ],
                    pointers: <GaugePointer>[
                      NeedlePointer(
                        value: 90,
                      ),
                    ],
                    annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                        widget: Container(
                          child: Text(
                            '90.0',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        angle: 90,
                        positionFactor: 0.5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Display the retrieved data
          Text('Name: ${profileViewModel.name}'),
          Text('Age: ${profileViewModel.age}'),
          Text('Gender: ${profileViewModel.gender == 1 ? 'Male' : 'Female'}'),
          Text('Height: ${bmiViewModel.height}'),
          Text('Current Weight: ${bmiViewModel.currentWeight}'),
          Text('Target Weight: ${bmiViewModel.targetWeight}'),
          Text('BMI: ${viewModel.bmi.toStringAsFixed(2)}'),
          Text('BMI Category: ${enumToString(viewModel.bmiCategory)}'),

          Spacer(), // Added Spacer to push the button to the bottom
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(352, 40)),
            onPressed: () async {
              Navigator.pushNamed(context, '/dashboard');
            },
            child: const Text('Continue To Personal Dashboard!'),
          ),
        ],
      ),
    );
  }
}
