import 'package:Rehlati/models/trip.dart';
import 'package:Rehlati/widgets/Trips%20Screen%20Widgets/trips_screen_cities_list_view_item.dart';
import 'package:flutter/material.dart';

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

  List<Trip> tripsList = <Trip>[
    Trip(
      image: 'https://images.pexels.com/photos/210186/pexels-photo-210186.jpeg',
      name: 'Trip 1 name',
      address: 'Trip 1 address',
      price: '500',
      rate: '4.2',
      favorite: false,
    ),
    Trip(
      image:
          'https://webneel.com/wallpaper/sites/default/files/images/08-2018/3-nature-wallpaper-mountain.jpg',
      name: 'Trip 2 name',
      address: 'Trip 2 address',
      price: '299',
      rate: '4.9',
      favorite: false,
    ),
    Trip(
      image:
          'https://i.pinimg.com/originals/15/f6/a3/15f6a3aac562ee0fadbbad3d4cdf47bc.jpg',
      name: 'Trip 3 name',
      address: 'Trip 3 address',
      price: '152',
      rate: '5',
      favorite: false,
    ),
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
                    return TripsScreenCitiesListViewItem(
                        city: citiesList[index]);
                  },
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                itemCount: tripsList.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 1.5,
                            offset: const Offset(0, 0.5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: Material(
                              borderRadius: const BorderRadiusDirectional.only(
                                topStart: Radius.circular(25),
                                topEnd: Radius.circular(25),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Image(
                                image: NetworkImage(tripsList[index].image),
                                fit: BoxFit.cover,
                                isAntiAlias: true,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          tripsList[index].name,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.place,
                                              color: Colors.grey,
                                              size: 20,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              tripsList[index].address,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          tripsList[index].favorite == true
                                              ? tripsList[index].favorite =
                                                  false
                                              : tripsList[index].favorite =
                                                  true;
                                        });
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.grey.shade300,
                                        radius: 25,
                                        child: Icon(
                                          Icons.favorite,
                                          color:
                                              tripsList[index].favorite == true
                                                  ? const Color(0xff5859F3)
                                                  : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Text(
                                      '\$${tripsList[index].price}',
                                      style: const TextStyle(
                                        color: Color(0xff5859F3),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.star_border,
                                      color: Color(0xff5859F3),
                                      size: 20,
                                    ),
                                    const SizedBox(width: 5),
                                    Text('${tripsList[index].rate} / 5'),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
