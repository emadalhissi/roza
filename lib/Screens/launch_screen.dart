import 'package:Rehlati/FireBase/cities_fb_controller.dart';
import 'package:Rehlati/Providers/cities_provider.dart';
import 'package:Rehlati/Screens/auth/login_screen.dart';
import 'package:Rehlati/Screens/home_screen.dart';
import 'package:Rehlati/models/city.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> launchData() async {
    List<City> cities = [];
    var citiesFromFirebase =
        await FirebaseFirestore.instance.collection('cities').get();

    if (citiesFromFirebase.docs.isNotEmpty) {
      for (var doc in citiesFromFirebase.docs) {
        cities.add(City.fromMap(doc.data()));
      }
    }

    Provider.of<CitiesProvider>(context, listen: false)
        .changeCitiesList(city: cities);
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
