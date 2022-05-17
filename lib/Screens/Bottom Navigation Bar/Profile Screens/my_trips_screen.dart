import 'package:Rehlati/FireBase/fb_firestore_trips_controller.dart';
import 'package:Rehlati/Screens/Office%20Screens/office_trip_screen.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:Rehlati/widgets/Profile%20Screen%20Widgets/my_trips_screen_list_view_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        title: Text(
          AppLocalizations.of(context)!.myTrips,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: StreamBuilder<QuerySnapshot>(
            stream: FbFireStoreTripsController().readMyTrips(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                List<QueryDocumentSnapshot> myTrips = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: myTrips.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OfficeTripScreen(
                              tripName: myTrips[index].get('name'),
                              tripTime: myTrips[index].get('time'),
                              tripDate: myTrips[index].get('date'),
                              tripCityId: myTrips[index].get('addressCityId'),
                              tripAddress:
                                  myTrips[index].get('addressCityName'),
                              tripAddressAr:
                                  myTrips[index].get('addressCityNameAr'),
                              price: myTrips[index].get('price'),
                              tripId: myTrips[index].get('tripId'),
                              tripDescription:
                                  myTrips[index].get('description'),
                              minPayment: myTrips[index].get('minPayment'),
                              tripImages: myTrips[index].get('images'),
                              officeId: myTrips[index].get('officeId'),
                            ),
                          ),
                        );
                      },
                      child: MyTripsScreenListViewItem(
                        image: myTrips[index].get('images')[0],
                        name: myTrips[index].get('name'),
                        time: myTrips[index].get('time'),
                        date: myTrips[index].get('date'),
                        address: SharedPrefController().getLang == 'en'
                            ? myTrips[index].get('addressCityName')
                            : myTrips[index].get('addressCityNameAr'),
                        price: myTrips[index].get('price'),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text(
                    AppLocalizations.of(context)!.youHaveNoTrips,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
