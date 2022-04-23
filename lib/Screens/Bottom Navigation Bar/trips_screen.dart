import 'package:Rehlati/FireBase/cities_fb_controller.dart';
import 'package:Rehlati/FireBase/fb_firestore_trips_controller.dart';
import 'package:Rehlati/Providers/cities_provider.dart';
import 'package:Rehlati/Screens/trip_screen.dart';
import 'package:Rehlati/models/trip.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:Rehlati/widgets/Trips%20Screen%20Widgets/trips_screen_cities_list_view_item.dart';
import 'package:Rehlati/widgets/Trips%20Screen%20Widgets/trip_screen_trips_list_view_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TripsScreen extends StatefulWidget {
  const TripsScreen({Key? key}) : super(key: key);

  @override
  _TripsScreenState createState() => _TripsScreenState();
}

class _TripsScreenState extends State<TripsScreen> {
  late TextEditingController searchEditingController;

  @override
  void initState() {
    super.initState();
    searchEditingController = TextEditingController();
  }

  @override
  void dispose() {
    searchEditingController.dispose();
    super.dispose();
  }

  String selectedCity = 'Bethlehem';

  List<QueryDocumentSnapshot> trips = [];
  List<QueryDocumentSnapshot> searchedTrips = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 55,
                child: PhysicalModel(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  elevation: 2.0,
                  shadowColor: Colors.grey,
                  child: TextField(
                    controller: searchEditingController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xff5859F3),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Color(0xffB9B9BB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: const BorderSide(color: Color(0xff63CEDA)),
                      ),
                    ),
                    onChanged: (String searchText) {
                      setState(() {
                        searchedTrips.clear();
                        for (int i = 0; i < trips.length; i++) {
                          if (trips[i]
                              .get('name')
                              .toLowerCase()
                              .contains(searchText.toLowerCase())) {
                            searchedTrips.add(trips[i]);
                          }
                        }
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width - 40,
                child: ListView.builder(
                  itemCount:
                      Provider.of<CitiesProvider>(context).citiesList.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedCity = Provider.of<CitiesProvider>(context,
                                  listen: false)
                              .citiesList[index]
                              .name;
                        });
                      },
                      child: TripsScreenCitiesListViewItem(
                        city: SharedPrefController().getLang == 'en'
                            ? Provider.of<CitiesProvider>(context)
                                .citiesList[index]
                                .name
                            : Provider.of<CitiesProvider>(context)
                                .citiesList[index]
                                .nameAr,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              searchedTrips.isNotEmpty ||
                      searchEditingController.text.isNotEmpty
                  ? ListView.builder(
                      itemCount: searchedTrips.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TripScreen(),
                              ),
                            );
                          },
                          child: TripsScreenTripsListViewItem(
                            image: searchedTrips[index].get('images')[0],
                            name: searchedTrips[index].get('name'),
                            time: searchedTrips[index].get('time'),
                            date: searchedTrips[index].get('date'),
                            address:
                                searchedTrips[index].get('addressCityName'),
                            addressAr:
                                searchedTrips[index].get('addressCityNameAr'),
                            price: searchedTrips[index].get('price'),
                            tripId: searchedTrips[index].id,
                          ),
                        );
                      },
                    )
                  : StreamBuilder<QuerySnapshot>(
                      stream:
                          FbFireStoreTripsController().readTrips(selectedCity),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData &&
                            snapshot.data!.docs.isNotEmpty) {
                          trips = snapshot.data!.docs;
                          return ListView.builder(
                            itemCount: trips.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const TripScreen(),
                                    ),
                                  );
                                },
                                child: TripsScreenTripsListViewItem(
                                  image: trips[index].get('images')[0],
                                  name: trips[index].get('name'),
                                  time: trips[index].get('time'),
                                  date: trips[index].get('date'),
                                  address: trips[index].get('addressCityName'),
                                  addressAr:
                                      trips[index].get('addressCityNameAr'),
                                  price: trips[index].get('price'),
                                  tripId: trips[index].id,
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                            child: Text(
                              'No Trips No Show!',
                              style: TextStyle(
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
            ],
          ),
        ),
      ),
    );
  }
}
