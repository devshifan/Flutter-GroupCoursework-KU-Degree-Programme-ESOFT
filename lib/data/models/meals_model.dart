class MealsModel {
  final int id;
  final String breakfast;
  final String lunch;
  final String snacks;
  final String dinner;
  final String bmiCategory;

  MealsModel({
    required this.id,
    required this.breakfast,
    required this.lunch,
    required this.snacks,
    required this.dinner,
    required this.bmiCategory,
  });

  factory MealsModel.fromMap(Map<String, dynamic> map) {
    return MealsModel(
      id: map['id'] as int,
      breakfast: map['breakfast'] as String,
      lunch: map['lunch'] as String,
      snacks: map['snacks'] as String,
      dinner: map['dinner'] as String,
      bmiCategory: map['bmicategory'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'breakfast': breakfast,
      'lunch': lunch,
      'snacks': snacks,
      'dinner': dinner,
      'bmicategory': bmiCategory,
    };
  }
}
