import 'package:flutter/foundation.dart';

class ProfileScreenViewModel with ChangeNotifier {
  String _name = '';
  int _age = 0;
  int? _gender;

  String get name => _name;
  int get age => _age;
  int? get gender => _gender;

  void setProfileData(String name, int age, int? gender) {
    _name = name;
    _age = age;
    _gender = gender;

    // Print for debugging
    print('Profile data set - Name: $_name, Age: $_age, Gender: $_gender');

    notifyListeners();
  }
}
