import 'package:Rehlati/Providers/trip_provider.dart';
import 'package:Rehlati/models/trip.dart';
import 'package:Rehlati/widgets/Trips%20Screen%20Widgets/trips_screen_cities_list_view_item.dart';
import 'package:Rehlati/widgets/trip_screen_trips_list_view_item.dart';
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

  List<String> citiesList = <String>[
    'All',
    'Hebron',
    'Nablus',
    'Ramallah',
    'Bethlehem',
    'Jenin',
    'Jericho',
  ];

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
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  itemCount: citiesList.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {});
                        Provider.of<TripProvider>(context, listen: false)
                            .selectedCity = citiesList[index];
                        if (Provider.of<TripProvider>(context, listen: false)
                                .selectedCity ==
                            'All') {
                          print('here here');
                          // for (int i = 0; i < tripsList.length; i++) {}
                          Provider.of<TripProvider>(context, listen: false)
                              .changeShownTrips(
                                  list: Provider.of<TripProvider>(context,
                                          listen: false)
                                      .tripsList);
                          print(
                              Provider.of<TripProvider>(context, listen: false)
                                  .shownTrips);
                        } else if (Provider.of<TripProvider>(context,
                                    listen: false)
                                .selectedCity !=
                            'All') {
                          print('here 2');
                          Provider.of<TripProvider>(context, listen: false)
                              .shownTrips
                              .clear();
                          // shownTrips = tripsList.where((element) => element.city == selectedCity).toList();

                        }
                        print(
                            'Selected City => ${Provider.of<TripProvider>(context, listen: false).selectedCity}');
                        print(
                            'tripsList => ${Provider.of<TripProvider>(context, listen: false).tripsList.toString()}');
                        // print('shownTrips => $shownTrips');

                        setState(() {});
                      },
                      child: TripsScreenCitiesListViewItem(
                        city: citiesList[index],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                itemCount: Provider.of<TripProvider>(context, listen: false)
                    .shownTrips
                    .length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return TripsScreenTripsListViewItem(
                    image: Provider.of<TripProvider>(context, listen: false)
                        .shownTrips[index]
                        .image,
                    name: Provider.of<TripProvider>(context, listen: false)
                        .shownTrips[index]
                        .name,
                    time: Provider.of<TripProvider>(context, listen: false)
                        .shownTrips[index]
                        .time,
                    date: Provider.of<TripProvider>(context, listen: false)
                        .shownTrips[index]
                        .date,
                    address: Provider.of<TripProvider>(context, listen: false)
                        .shownTrips[index]
                        .address,
                    price: Provider.of<TripProvider>(context, listen: false)
                        .shownTrips[index]
                        .price,
                    rate: Provider.of<TripProvider>(context, listen: false)
                        .shownTrips[index]
                        .rate,
                    favorite: Provider.of<TripProvider>(context, listen: false)
                        .shownTrips[index]
                        .favorite,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
