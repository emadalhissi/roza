import 'package:Rehlati/Screens/Bottom%20Navigation%20Bar/favorites_screen.dart';
import 'package:Rehlati/Screens/Bottom%20Navigation%20Bar/reservations_screen.dart';
import 'package:Rehlati/Screens/Bottom%20Navigation%20Bar/profile_screen.dart';
import 'package:Rehlati/Screens/Bottom%20Navigation%20Bar/trips_screen.dart';
import 'package:Rehlati/models/bn_models/bn_screen.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<BnScreen> _bnScreens = <BnScreen>[
      BnScreen(title: 'Trips', widget: const TripsScreen()),
      BnScreen(
          title: SharedPrefController().getAccountType == 'user'
              ? 'My Reservations'
              : 'My Orders',
          widget: const ReservationsScreen()),
      BnScreen(title: 'Favorites', widget: const FavoritesScreen()),
      BnScreen(title: 'Profile', widget: const ProfileScreen()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _bnScreens[_currentIndex].title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        leading: const SizedBox.shrink(),
        leadingWidth: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: _bnScreens[_currentIndex].widget,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            activeIcon: Icon(
              Icons.home,
              color: Color(0xff5859F3),
            ),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_cart),
            label: SharedPrefController().getAccountType == 'user'
                ? 'Reservations'
                : 'Orders',
            activeIcon: const Icon(
              Icons.shopping_cart,
              color: Color(0xff5859F3),
            ),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
            activeIcon: Icon(
              Icons.favorite,
              color: Color(0xff5859F3),
            ),
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            activeIcon: Icon(
              Icons.account_circle,
              color: Color(0xff5859F3),
            ),
          ),
        ],
      ),
    );
  }
}
