import 'package:Rehlati/Screens/add_reservation_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  List<String> imageList = <String>[
    'https://images.pexels.com/photos/210186/pexels-photo-210186.jpeg',
    'https://webneel.com/wallpaper/sites/default/files/images/08-2018/3-nature-wallpaper-mountain.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
          'Back',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 350,
              child: Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      height: 350,
                      viewportFraction: 1,
                    ),
                    items: imageList
                        .map(
                          (image) => Container(
                            height: 350,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: NetworkImage(image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  PositionedDirectional(
                    bottom: 5,
                    end: 15,
                    child: Chip(
                      label: Text(
                        '3 Orders',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      backgroundColor: Color(0xff5859F3).withOpacity(0.40),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Headphone Joss',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$234',
                            style: TextStyle(
                              color: Color(0xff5859F3),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                        radius: 23,
                        child: Icon(
                          Icons.favorite,
                          color: const Color(0xff5859F3),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Table(
                    children: [
                      TableRow(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.timer,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '12:30',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.date_range,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '2022-03-09',
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
                      TableRow(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.place,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Trip 1 address',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.attach_money,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                'Min. Payment: \$150',
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
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Trip Details',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation',
                    style: TextStyle(
                      color: Color(0xff8A8A8E),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        child: const Text(
          'Order',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddReservationScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 70),
          padding: EdgeInsets.zero,
          primary: const Color(0xff5859F3),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
