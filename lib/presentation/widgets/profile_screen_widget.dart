import 'package:coursework_group/presentation/viewmodels/profile_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfileScreenWidget extends StatefulWidget {
  const ProfileScreenWidget({Key? key}) : super(key: key);

  @override
  _ProfileScreenWidgetState createState() => _ProfileScreenWidgetState();
}

class _ProfileScreenWidgetState extends State<ProfileScreenWidget> {
  final ProfileScreenViewModel viewModel = ProfileScreenViewModel();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  int? gender;

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
                children: <Widget>[
                  _header(),
                  Column(
                    children: [
                      // _sectionTitle('Tell About You'),
                      _inputField('What\'s your Name', nameController),
                      _inputField('What\'s your Age', ageController, true),
                      _genderSelection(),
                    ],
                  ),
                  SizedBox(height: 16),
                  _nextButton(context),
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

  Widget _header() {
    return Column(
      children: [
        SizedBox(height: 20),
        Image.asset(
          'assets/images/profile.jpg', // Replace with the path to your image
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 20),
        Text(
          'Create Your Profile',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Add your details for a personalized experience',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 26.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller,
      [bool isNumeric = false]) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        controller: controller,
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        inputFormatters: isNumeric
            ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
            : null,
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
          prefixIcon: Icon(Icons.person, color: Colors.black),
        ),
      ),
    );
  }

  Widget _genderSelection() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'What\'s your Gender',
            style: TextStyle(
              fontSize: 15.0,
              color: Colors.black,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              value: 1,
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
              activeColor: Colors.black,
            ),
            Text('Male', style: TextStyle(color: Colors.black)),
            Radio(
              value: 0,
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value;
                });
              },
              activeColor: Colors.black,
            ),
            Text('Female', style: TextStyle(color: Colors.black)),
          ],
        ),
      ],
    );
  }

  Widget _nextButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(360, 40),
        primary: Colors.black,
      ),
      onPressed: () async {
        var profileViewModel =
            Provider.of<ProfileScreenViewModel>(context, listen: false);

        profileViewModel.setProfileData(
          nameController.text,
          int.tryParse(ageController.text) ?? 0,
          gender,
        );

        Navigator.pushNamed(context, '/bmi');
      },
      child: const Text('Next', style: TextStyle(color: Colors.white)),
    );
  }
}
