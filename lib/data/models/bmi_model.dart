import 'package:flutter/foundation.dart';

enum BMICategory {
  underweight,
  normalWeight,
  overweight,
  obesity,
}

@immutable
class BMIResult {
  final double bmi;
  final BMICategory category;

  const BMIResult({
    required this.bmi,
    required this.category,
  });
}

BMICategory categorizeBMI(double bmi) {
  if (bmi < 18.5) {
    return BMICategory.underweight;
  } else if (bmi >= 18.5 && bmi <= 24.9) {
    return BMICategory.normalWeight;
  } else if (bmi >= 25 && bmi <= 29.9) {
    return BMICategory.overweight;
  } else {
    return BMICategory.obesity;
  }
}
