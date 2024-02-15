class WorkoutModel {
  final int id;
  final String lowerbody;
  final String upperbody;
  final String gender;
  final String bmiCategory;

  WorkoutModel({
    required this.id,
    required this.lowerbody,
    required this.upperbody,
    required this.gender,
    required this.bmiCategory,
  });

  factory WorkoutModel.fromMap(Map<String, dynamic> map) {
    return WorkoutModel(
      id: map['id'] as int,
      lowerbody: map['lowerbody'] as String,
      upperbody: map['upperbody'] as String,
      gender: map['gender'] as String,
      bmiCategory: map['bmicategory'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lowerbody': lowerbody,
      'upperbody': upperbody,
      'gender': gender,
      'bmicategory': bmiCategory,
    };
  }
}
