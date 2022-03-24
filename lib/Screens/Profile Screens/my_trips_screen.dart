import 'package:Rehlati/widgets/Favorites%20Screen%20Widgets/favorites_screen_list_view_item.dart';
import 'package:Rehlati/widgets/Profile%20Screen%20Widgets/my_trips_screen_list_view_item.dart';
import 'package:flutter/material.dart';

class MyTripsScreen extends StatefulWidget {
  const MyTripsScreen({Key? key}) : super(key: key);

  @override
  _MyTripsScreenState createState() => _MyTripsScreenState();
}

class _MyTripsScreenState extends State<MyTripsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leadingWidth: 25,
        leading: IconButton(
          padding: const EdgeInsets.only(left: 20),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'My Trips',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              MyTripsScreenListViewItem(
                image: 'assets/images/my_photo.jpg',
                name: 'Favorite Name',
                time: '03:45',
                date: '2022-08-09',
                address: 'Address',
                favorite: false,
                price: '599',
              ),
              MyTripsScreenListViewItem(
                image: 'assets/images/my_photo.jpg',
                name: 'Favorite Name',
                time: '03:45',
                date: '2022-08-09',
                address: 'Address',
                favorite: false,
                price: '599',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
