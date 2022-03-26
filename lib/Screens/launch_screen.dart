import 'package:Rehlati/FireBase/cities_fb_controller.dart';
import 'package:Rehlati/Providers/cities_provider.dart';
import 'package:Rehlati/Screens/auth/login_screen.dart';
import 'package:Rehlati/Screens/home_screen.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  @override
  void initState() {
    super.initState();
    launchData();
    Future.delayed(const Duration(seconds: 3), () {
      String route = SharedPrefController().checkLoggedIn
          ? '/home_screen'
          : '/login_screen';
      Navigator.pushReplacementNamed(context, route);
    });
  }

  void launchData() {
    // List<QueryDocumentSnapshot> c = CitiesFbController().readCities();
    // Provider.of<CitiesProvider>(context).changeCitiesList(city: cities);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/trip.png',
              scale: 2.1,
            ),
            const SizedBox(height: 20),
            const Text(
              'Rehlati',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
