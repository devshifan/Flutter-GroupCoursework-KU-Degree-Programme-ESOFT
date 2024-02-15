import 'package:flutter/foundation.dart';

class BmiScreenViewModel with ChangeNotifier {
  double _height = 0.0;
  double _currentWeight = 0.0;
  double _targetWeight = 0.0;

  double get height => _height;
  double get currentWeight => _currentWeight;
  double get targetWeight => _targetWeight;

  void setBmiData(double height, double currentWeight, double targetWeight) {
    _height = height;
    _currentWeight = currentWeight;
    _targetWeight = targetWeight;
    notifyListeners();
  }
}
