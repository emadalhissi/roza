import 'package:Rehlati/Providers/trip_provider.dart';
import 'package:Rehlati/models/trip.dart';
import 'package:Rehlati/widgets/Trips%20Screen%20Widgets/trips_screen_cities_list_view_item.dart';
import 'package:Rehlati/widgets/Trips%20Screen%20Widgets/trip_screen_trips_list_view_item.dart';
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

  String selectedCity = 'All';

  List<String> citiesList = <String>[
    'All',
    'Hebron',
    'Nablus',
    'Ramallah',
    'Bethlehem',
    'Jenin',
    'Jericho',
  ];

  List<Trip> hebronTripsList = <Trip>[
    Trip(
      image: 'https://images.pexels.com/photos/210186/pexels-photo-210186.jpeg',
      name: 'Trip 1 name',
      time: '12:30',
      date: '2022-03-09',
      address: 'Trip 1 address',
      price: '500',
      rate: '4.2',
      favorite: false,
      city: 'Hebron',
    ),
    Trip(
      image:
          'https://webneel.com/wallpaper/sites/default/files/images/08-2018/3-nature-wallpaper-mountain.jpg',
      name: 'Trip 2 name',
      time: '12:30',
      date: '2022-03-09',
      address: 'Trip 2 address',
      price: '299',
      rate: '4.9',
      favorite: false,
      city: 'Hebron',
    ),
    Trip(
      image:
          'https://i.pinimg.com/originals/15/f6/a3/15f6a3aac562ee0fadbbad3d4cdf47bc.jpg',
      name: 'Trip 3 name',
      time: '12:30',
      date: '2022-03-09',
      address: 'Trip 3 address',
      price: '152',
      rate: '5',
      favorite: false,
      city: 'Hebron',
    ),
  ];
  List<Trip> bethlehemTripsList = <Trip>[
    Trip(
      image: 'https://images.pexels.com/photos/210186/pexels-photo-210186.jpeg',
      name: 'Trip 1 name',
      time: '12:30',
      date: '2022-03-09',
      address: 'Trip 1 address',
      price: '500',
      rate: '4.2',
      favorite: false,
      city: 'Bethlehem',
    ),
    Trip(
      image:
          'https://i.pinimg.com/originals/15/f6/a3/15f6a3aac562ee0fadbbad3d4cdf47bc.jpg',
      name: 'Trip 3 name',
      time: '12:30',
      date: '2022-03-09',
      address: 'Trip 3 address',
      price: '152',
      rate: '5',
      favorite: false,
      city: 'Bethlehem',
    ),
  ];
  List<Trip> jerichoTripsList = <Trip>[
    Trip(
      image: 'https://images.pexels.com/photos/210186/pexels-photo-210186.jpeg',
      name: 'Trip 1 name',
      time: '12:30',
      date: '2022-03-09',
      address: 'Trip 1 address',
      price: '500',
      rate: '4.2',
      favorite: false,
      city: 'Jericho',
    ),
    Trip(
      image:
          'https://webneel.com/wallpaper/sites/default/files/images/08-2018/3-nature-wallpaper-mountain.jpg',
      name: 'Trip 2 name',
      time: '12:30',
      date: '2022-03-09',
      address: 'Trip 2 address',
      price: '299',
      rate: '4.9',
      favorite: false,
      city: 'Jericho',
    ),
    Trip(
      image:
          'https://i.pinimg.com/originals/15/f6/a3/15f6a3aac562ee0fadbbad3d4cdf47bc.jpg',
      name: 'Trip 3 name',
      time: '12:30',
      date: '2022-03-09',
      address: 'Trip 3 address',
      price: '152',
      rate: '5',
      favorite: false,
      city: 'Jericho',
    ),
    Trip(
      image:
          'https://i.pinimg.com/originals/15/f6/a3/15f6a3aac562ee0fadbbad3d4cdf47bc.jpg',
      name: 'Trip 3 name',
      time: '12:30',
      date: '2022-03-09',
      address: 'Trip 3 address',
      price: '152',
      rate: '5',
      favorite: false,
      city: 'Jericho',
    ),
  ];

  late List<Trip> allTripsList =
      hebronTripsList + bethlehemTripsList + jerichoTripsList;

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
                        setState(() {
                          selectedCity = citiesList[index];
                        });

                        print('Selected City => $selectedCity');
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
                itemCount: checkListType().length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return TripsScreenTripsListViewItem(
                    image: checkListType()[index].image,
                    name: checkListType()[index].name,
                    time: checkListType()[index].time,
                    date: checkListType()[index].date,
                    address: checkListType()[index].address,
                    price: checkListType()[index].price,
                    rate: checkListType()[index].rate,
                    favorite: checkListType()[index].favorite,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Trip> checkListType() {
    if (selectedCity == 'All') {
      return allTripsList;
    } else if (selectedCity == 'Hebron') {
      return hebronTripsList;
    } else if (selectedCity == 'Bethlehem') {
      return bethlehemTripsList;
    } else if (selectedCity == 'Jericho') {
      return jerichoTripsList;
    } else {
      return [];
    }
  }
}
