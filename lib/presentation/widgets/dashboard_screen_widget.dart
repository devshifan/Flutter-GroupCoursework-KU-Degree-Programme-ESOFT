import 'package:coursework_group/presentation/providers/userame_provider.dart';
import 'package:coursework_group/presentation/viewmodels/first_time_user_check_viewmodel.dart';
import 'package:coursework_group/presentation/viewmodels/profile_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:coursework_group/data/services/user_service.dart';
import 'package:coursework_group/presentation/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:coursework_group/presentation/viewmodels/dashboard_screen_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreenWidget extends StatefulWidget {
  const DashboardScreenWidget({Key? key}) : super(key: key);

  @override
  _DashboardScreenWidgetState createState() => _DashboardScreenWidgetState();
}

class _DashboardScreenWidgetState extends State<DashboardScreenWidget> {
  late String loggedInUsername = '';
  late String demo = '';
  final UserService _userService = UserService();
  final FirstTimeUserCheckViewModel viewModelFirstTimeUserCheck =
      FirstTimeUserCheckViewModel();

  @override
  void initState() {
    super.initState();
    var viewModel =
        Provider.of<DashboardScreenViewModel>(context, listen: false);
    viewModel.loadProfileDashboardDetails();
    loadUsernameFromPreferences();
  }

  Future<void> loadUsernameFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('loggedInUsername');
    print(
        "<------Print------>loggedInUsername storedUsername: $storedUsername");
    setState(() {
      loggedInUsername =
          storedUsername ?? ''; // Use an empty string if null demo
      demo = storedUsername ?? ''; // Use an empty string if null
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    var viewModel = Provider.of<DashboardScreenViewModel>(context);

    final usernameProvider = Provider.of<UsernameProvider>(context);
    String? loggedInUsername = usernameProvider.loggedInUsername;

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Column(
          children: <Widget>[
            _buildHeader(viewModel.profileDetails),
            _buildFeaturesSection(context),
            _buildSignoutButton(userProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> profileDetails) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 238, 231, 231),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30), // Curves at the bottom
          top: Radius.circular(30), // Curves at the top
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5),
          Text(
            'Dashboard',
            style: TextStyle(
              fontSize: 36.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          if (profileDetails.isNotEmpty) ...[
            _buildProfileDetail('Profile Name', profileDetails['profilename']),
            _buildProfileDetail('Gender', profileDetails['gender']),
            _buildProfileDetail('Age', profileDetails['age'].toString()),
            _buildProfileDetail('BMI Category', profileDetails['bmiCategory']),
          ],
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildFeatureCard(
                  'assets/images/workoutplan.jpg',
                  'Workout Plan',
                  '/workout',
                  Icons.fitness_center,
                ),
                _buildFeatureCard(
                  'assets/images/mealplannew.jpg',
                  'Meal Plan',
                  '/meal',
                  Icons.restaurant_menu,
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    String imagePath,
    String title,
    String route,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            // Navigate to the specified route
            Navigator.pushNamed(context, route);
          },
          child: Column(
            children: [
              Icon(icon,
                  size: 30, color: Colors.black), // Change icon color to black
              SizedBox(height: 5),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Change text color to black
                ),
              ),
            ],
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.white, // Change background color to white
            onPrimary: Colors.black, // Change text color to black
            minimumSize: Size(160, 40),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.blueGrey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignoutButton(UserProvider userProvider) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () async {
          await _updateUserStatus(userProvider);
          Navigator.pushReplacementNamed(context, '/login');
        },
        child: const Text('Signout'),
        style: ElevatedButton.styleFrom(
          primary: Colors.red, // Background color
          onPrimary: Colors.white, // Text color
          minimumSize: Size(160, 40),
        ),
      ),
    );
  }

  Future<void> _updateUserStatus(UserProvider userProvider) async {
    print("loggedInUsername check last: $demo");
    try {
      String? username = userProvider.username;
      String? newusername = demo; // Corrected line
      if (username != null) {
        await _userService.updateUserStatus(newusername, false);
        userProvider.setUser('');
      }
    } catch (e) {
      print("Error during signout: $e");
    }
  }
}
