import 'package:Rehlati/widgets/Favorites%20Screen%20Widgets/favorites_screen_list_view_item.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              FavoritesScreenListViewItem(
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
