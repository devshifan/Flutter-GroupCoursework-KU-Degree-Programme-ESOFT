import 'package:coursework_group/presentation/providers/userame_provider.dart';
import 'package:coursework_group/presentation/screens/lowerbody_screen.dart';
import 'package:coursework_group/presentation/screens/upperbody_screen.dart';
import 'package:coursework_group/presentation/viewmodels/bmi_screen_viewmodel.dart';
import 'package:coursework_group/presentation/viewmodels/breakfast_screen_viewmodel.dart';
import 'package:coursework_group/presentation/viewmodels/dashboard_screen_viewmodel.dart';
import 'package:coursework_group/presentation/viewmodels/dinner_screen_viewmodel.dart';
import 'package:coursework_group/presentation/viewmodels/lowerbody_screen_viewmodel.dart';
import 'package:coursework_group/presentation/viewmodels/lunch_screen_viewmodel.dart';
import 'package:coursework_group/presentation/viewmodels/process_screen_viewmodel.dart';
import 'package:coursework_group/presentation/viewmodels/snacks_screen_viewmodel.dart';
import 'package:coursework_group/presentation/viewmodels/uppperbody_screen_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'presentation/providers/user_provider.dart';
import 'presentation/viewmodels/profile_screen_viewmodel.dart';
import 'presentation/screens/bmi_screen.dart';
import 'presentation/screens/breakfast_screen.dart';
import 'presentation/screens/dashboard_screen.dart';
import 'presentation/screens/dinner_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/lunch_screen.dart';
import 'presentation/screens/meal_screen.dart';
import 'presentation/screens/process_screen.dart';
import 'presentation/screens/profile_screen.dart';
import 'presentation/screens/signup_screen.dart';
import 'presentation/screens/snacks_screen.dart';
import 'presentation/screens/user_registration_screen.dart';
import 'presentation/screens/welcome_screen.dart';
import 'presentation/screens/workout_screen.dart';
import 'presentation/widgets/first_time_user_check.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => UsernameProvider()),
        ChangeNotifierProvider(create: (_) => ProfileScreenViewModel()),
        ChangeNotifierProvider(create: (_) => BmiScreenViewModel()),
        ChangeNotifierProvider(create: (_) => ProcessScreenViewModel()),
        ChangeNotifierProvider(create: (_) => BreakfastScreenViewModel()),
        ChangeNotifierProvider(create: (_) => LunchScreenViewModel()),
        ChangeNotifierProvider(create: (_) => SnacksScreenViewModel()),
        ChangeNotifierProvider(create: (_) => DinnerScreenViewModel()),
        ChangeNotifierProvider(create: (_) => UpperbodyScreenViewModel()),
        ChangeNotifierProvider(create: (_) => LowerbodyScreenViewModel()),
        ChangeNotifierProvider(create: (_) => DashboardScreenViewModel()),
      ],
      child: MaterialApp(
        title: 'FlexUp',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomeScreen(),
          '/userCheck': (context) => FirstTimeUserCheck(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/register': (context) => UserRegistrationScreen(),
          '/profile': (context) => ProfileScreen(),
          '/bmi': (context) => BmiScreen(),
          '/process': (context) => ProcessScreen(),
          '/dashboard': (context) => DashboardScreen(),
          '/workout': (context) => WorkoutScreen(),
          '/meal': (context) => MealScreen(),
          '/breakfast': (context) => BreakfastScreen(),
          '/lunch': (context) => LunchScreen(),
          '/snacks': (context) => SnacksScreen(),
          '/dinner': (context) => DinnerScreen(),
          '/upperbody': (context) => UpperbodyScreen(),
          '/lowerbody': (context) => LowerbodyScreen(),
        },
      ),
    );
  }
}
