import 'package:coursework_group/presentation/viewmodels/bmi_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BmiScreenWidget extends StatefulWidget {
  const BmiScreenWidget({Key? key}) : super(key: key);

  @override
  _BmiScreenWidgetState createState() => _BmiScreenWidgetState();
}

class _BmiScreenWidgetState extends State<BmiScreenWidget> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController currentWeightController = TextEditingController();
  final TextEditingController targetWeightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _background(),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _bmiInfo(context),
                  SizedBox(height: 16),
                  _bmiInputFields(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _background() {
    return Container(
      color: Colors.white,
    );
  }

  Widget _bmiInfo(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            ' BMI Target',
            style: TextStyle(
              fontSize: 26.0,
              color: Colors.blueGrey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Image.asset(
          'assets/images/bmi.jpg', // Replace with the path to your BMI image
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
        _inputFieldWithIcon('Height (Cm)', Icons.height, heightController),
        _inputFieldWithIcon('Current Weight (Kg)', Icons.accessibility_new,
            currentWeightController),
        _inputFieldWithIcon('Target Weight (Kg)', Icons.bar_chart,
            targetWeightController), // Using a different icon for "Target Weight"
      ],
    );
  }

  Widget _inputFieldWithIcon(
      String label, IconData icon, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(color: Colors.black54),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.black),
          ),
          prefixIcon: Icon(icon, color: Colors.black),
        ),
      ),
    );
  }

  Widget _bmiInputFields(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(360, 40),
        primary: Colors.black,
      ),
      onPressed: () async {
        _saveBmiData(context);
      },
      child: const Text('Next', style: TextStyle(color: Colors.white)),
    );
  }

  void _saveBmiData(BuildContext context) {
    final double height = double.tryParse(heightController.text) ?? 0.0;
    final double currentWeight =
        double.tryParse(currentWeightController.text) ?? 0.0;
    final double targetWeight =
        double.tryParse(targetWeightController.text) ?? 0.0;

    if (_validateInputs(height, currentWeight, targetWeight)) {
      final BmiScreenViewModel viewModel =
          Provider.of<BmiScreenViewModel>(context, listen: false);
      viewModel.setBmiData(height, currentWeight, targetWeight);

      Navigator.pushNamed(context, '/process');
    }
  }

  bool _validateInputs(
      double height, double currentWeight, double targetWeight) {
    if (height <= 0) {
      _showErrorDialog('Invalid height');
      return false;
    } else if (currentWeight <= 0) {
      _showErrorDialog('Invalid current weight');
      return false;
    } else if (targetWeight <= 0) {
      _showErrorDialog('Invalid target weight');
      return false;
    }
    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
