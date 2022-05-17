import 'package:Rehlati/Screens/Bottom%20Navigation%20Bar/favorites_screen.dart';
import 'package:Rehlati/Screens/Bottom%20Navigation%20Bar/reservations_screen.dart';
import 'package:Rehlati/Screens/Bottom%20Navigation%20Bar/profile_screen.dart';
import 'package:Rehlati/Screens/Bottom%20Navigation%20Bar/trips_screen.dart';
import 'package:Rehlati/models/bn_models/bn_screen.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final List<BnScreen> _bnScreens =
        SharedPrefController().getAccountType == 'admin'
            ? <BnScreen>[
                BnScreen(
                    title: AppLocalizations.of(context)!.trips,
                    widget: const TripsScreen()),
                BnScreen(
                    title: AppLocalizations.of(context)!.reservations,
                    widget: const ReservationsScreen()),
                BnScreen(
                    title: AppLocalizations.of(context)!.profile,
                    widget: const ProfileScreen()),
              ]
            : <BnScreen>[
                BnScreen(
                    title: AppLocalizations.of(context)!.trips,
                    widget: const TripsScreen()),
                BnScreen(
                    title: SharedPrefController().getAccountType == 'user'
                        ? AppLocalizations.of(context)!.myReservations
                        : AppLocalizations.of(context)!.myOrders,
                    widget: const ReservationsScreen()),
                BnScreen(
                    title: AppLocalizations.of(context)!.favorites,
                    widget: const FavoritesScreen()),
                BnScreen(
                    title: AppLocalizations.of(context)!.profile,
                    widget: const ProfileScreen()),
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
        items: SharedPrefController().getAccountType == 'admin'
            ? [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: AppLocalizations.of(context)!.trips,
                  activeIcon: const Icon(
                    Icons.home,
                    color: Color(0xff5859F3),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.shopping_cart),
                  label: AppLocalizations.of(context)!.reservations,
                  activeIcon: const Icon(
                    Icons.shopping_cart,
                    color: Color(0xff5859F3),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.account_circle),
                  label: AppLocalizations.of(context)!.profile,
                  activeIcon: const Icon(
                    Icons.account_circle,
                    color: Color(0xff5859F3),
                  ),
                ),
              ]
            : [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: AppLocalizations.of(context)!.trips,
                  activeIcon: const Icon(
                    Icons.home,
                    color: Color(0xff5859F3),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.shopping_cart),
                  label: SharedPrefController().getAccountType == 'user'
                      ? AppLocalizations.of(context)!.reservations
                      : AppLocalizations.of(context)!.orders,
                  activeIcon: const Icon(
                    Icons.shopping_cart,
                    color: Color(0xff5859F3),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite),
                  label: AppLocalizations.of(context)!.favorites,
                  activeIcon: const Icon(
                    Icons.favorite,
                    color: Color(0xff5859F3),
                  ),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.account_circle),
                  label: AppLocalizations.of(context)!.profile,
                  activeIcon: const Icon(
                    Icons.account_circle,
                    color: Color(0xff5859F3),
                  ),
                ),
              ],
      ),
    );
  }
}
