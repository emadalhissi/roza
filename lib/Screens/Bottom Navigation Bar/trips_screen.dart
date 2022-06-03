import 'package:Rehlati/FireBase/fb_firestore_trips_controller.dart';
import 'package:Rehlati/Providers/cities_provider.dart';
import 'package:Rehlati/Screens/Office%20Screens/office_trip_screen.dart';
import 'package:Rehlati/Screens/trip_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:Rehlati/widgets/Trips%20Screen%20Widgets/trips_screen_cities_list_view_item.dart';
import 'package:Rehlati/widgets/Trips%20Screen%20Widgets/trips_screen_trips_list_view_item.dart';
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
                      hintText: AppLocalizations.of(context)!.search,
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
                            if (SharedPrefController().getAccountType ==
                                'admin') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TripScreen(
                                    tripName: searchedTrips[index].get('name'),
                                    tripTime: searchedTrips[index].get('time'),
                                    tripDate: searchedTrips[index].get('date'),
                                    tripAddress: searchedTrips[index]
                                        .get('addressCityName'),
                                    tripAddressAr: searchedTrips[index]
                                        .get('addressCityNameAr'),
                                    price: searchedTrips[index].get('price'),
                                    tripId: searchedTrips[index].id,
                                    tripDescription:
                                        searchedTrips[index].get('description'),
                                    minPayment:
                                        searchedTrips[index].get('minPayment'),
                                    tripImages:
                                        searchedTrips[index].get('images'),
                                    tripAddressId: searchedTrips[index]
                                        .get('addressCityId'),
                                    officeName:
                                        searchedTrips[index].get('officeName'),
                                    officeEmail:
                                        searchedTrips[index].get('officeEmail'),
                                    officeId:
                                        searchedTrips[index].get('officeId'),
                                    isAdmin: true,
                                    space: searchedTrips[index].get('space'),
                                  ),
                                ),
                              );
                            } else if (searchedTrips[index]
                                    .get('officeEmail') ==
                                SharedPrefController().getEmail) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OfficeTripScreen(
                                    tripName: searchedTrips[index].get('name'),
                                    tripTime: searchedTrips[index].get('time'),
                                    tripDate: searchedTrips[index].get('date'),
                                    tripAddress: searchedTrips[index]
                                        .get('addressCityName'),
                                    tripAddressAr: searchedTrips[index]
                                        .get('addressCityNameAr'),
                                    price: searchedTrips[index].get('price'),
                                    tripId: searchedTrips[index].id,
                                    tripDescription:
                                        searchedTrips[index].get('description'),
                                    minPayment:
                                        searchedTrips[index].get('minPayment'),
                                    tripImages:
                                        searchedTrips[index].get('images'),
                                    tripCityId: searchedTrips[index]
                                        .get('addressCityId'),
                                    officeId:
                                        searchedTrips[index].get('officeId'),
                                    number: searchedTrips[index].get('number'),
                                    space: searchedTrips[index].get('space'),
                                  ),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TripScreen(
                                    tripName: searchedTrips[index].get('name'),
                                    tripTime: searchedTrips[index].get('time'),
                                    tripDate: searchedTrips[index].get('date'),
                                    tripAddress: searchedTrips[index]
                                        .get('addressCityName'),
                                    tripAddressAr: searchedTrips[index]
                                        .get('addressCityNameAr'),
                                    price: searchedTrips[index].get('price'),
                                    tripId: searchedTrips[index].id,
                                    tripDescription:
                                        searchedTrips[index].get('description'),
                                    minPayment:
                                        searchedTrips[index].get('minPayment'),
                                    tripImages:
                                        searchedTrips[index].get('images'),
                                    tripAddressId: searchedTrips[index]
                                        .get('addressCityId'),
                                    officeName:
                                        searchedTrips[index].get('officeName'),
                                    officeEmail:
                                        searchedTrips[index].get('officeEmail'),
                                    officeId:
                                        searchedTrips[index].get('officeId'),
                                    space: searchedTrips[index].get('space'),
                                  ),
                                ),
                              );
                            }
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
                            officeId: searchedTrips[index].get('officeId'),
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
                                  if (SharedPrefController().getAccountType ==
                                      'admin') {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TripScreen(
                                          tripName: trips[index].get('name'),
                                          tripTime: trips[index].get('time'),
                                          tripDate: trips[index].get('date'),
                                          tripAddress: trips[index]
                                              .get('addressCityName'),
                                          tripAddressAr: trips[index]
                                              .get('addressCityNameAr'),
                                          price: trips[index].get('price'),
                                          tripId: trips[index].id,
                                          tripDescription:
                                              trips[index].get('description'),
                                          minPayment:
                                              trips[index].get('minPayment'),
                                          tripImages:
                                              trips[index].get('images'),
                                          tripAddressId:
                                              trips[index].get('addressCityId'),
                                          officeName:
                                              trips[index].get('officeName'),
                                          officeEmail:
                                              trips[index].get('officeEmail'),
                                          officeId:
                                              trips[index].get('officeId'),
                                          isAdmin: true,
                                          space: trips[index].get('space'),
                                        ),
                                      ),
                                    );
                                  } else if (trips[index].get('officeEmail') ==
                                      SharedPrefController().getEmail) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OfficeTripScreen(
                                          tripName: trips[index].get('name'),
                                          tripTime: trips[index].get('time'),
                                          tripDate: trips[index].get('date'),
                                          tripAddress: trips[index]
                                              .get('addressCityName'),
                                          tripAddressAr: trips[index]
                                              .get('addressCityNameAr'),
                                          price: trips[index].get('price'),
                                          tripId: trips[index].id,
                                          tripDescription:
                                              trips[index].get('description'),
                                          minPayment:
                                              trips[index].get('minPayment'),
                                          tripImages:
                                              trips[index].get('images'),
                                          tripCityId:
                                              trips[index].get('addressCityId'),
                                          officeId:
                                              trips[index].get('officeId'),
                                          number: trips[index].get('number'),
                                          space: trips[index].get('space'),
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TripScreen(
                                          tripName: trips[index].get('name'),
                                          tripTime: trips[index].get('time'),
                                          tripDate: trips[index].get('date'),
                                          tripAddress: trips[index]
                                              .get('addressCityName'),
                                          tripAddressAr: trips[index]
                                              .get('addressCityNameAr'),
                                          price: trips[index].get('price'),
                                          tripId: trips[index].id,
                                          tripDescription:
                                              trips[index].get('description'),
                                          minPayment:
                                              trips[index].get('minPayment'),
                                          tripImages:
                                              trips[index].get('images'),
                                          tripAddressId:
                                              trips[index].get('addressCityId'),
                                          officeName:
                                              trips[index].get('officeName'),
                                          officeEmail:
                                              trips[index].get('officeEmail'),
                                          officeId:
                                              trips[index].get('officeId'),
                                          space: trips[index].get('space'),
                                        ),
                                      ),
                                    );
                                  }
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
                                  officeId: trips[index].get('officeId'),
                                ),
                              );
                            },
                          );
                        } else {
                          return Center(
                            child: Text(
                              AppLocalizations.of(context)!.noTrips,
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
            ],
          ),
        ),
      ),
    );
  }
}
