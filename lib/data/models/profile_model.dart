class ProfileModel {
  final int id;
  final String username;
  final String profilename;
  final int age;
  final String gender;
  final String bmiCategory; // Add this property

  ProfileModel({
    required this.id,
    required this.username,
    required this.profilename,
    required this.age,
    required this.gender,
    required this.bmiCategory,
  });

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'] as int,
      username: map['username'] as String,
      profilename: map['profilename'] as String,
      age: map['age'] as int,
      gender: map['gender'] as String,
      bmiCategory: map['bmicategory'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'profilename': profilename,
      'age': age,
      'gender': gender,
      'bmicategory': bmiCategory,
    };
  }
}
