import 'package:Rehlati/widgets/Reservations%20Screen%20Widgets/reservations_screen_list_view_item.dart';
import 'package:flutter/material.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({Key? key}) : super(key: key);

  @override
  _ReservationsScreenState createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 0,
          leading: const SizedBox.shrink(),
          title: const SizedBox.shrink(),
          toolbarHeight: 0,
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                // print(index);
              });
            },
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsets.zero,
            indicatorPadding: EdgeInsets.zero,
            indicatorColor: const Color(0xff5859F3),
            labelColor: const Color(0xff5859F3),
            unselectedLabelColor: Colors.black,
            labelStyle: const TextStyle(fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Accepted'),
              Tab(text: 'Waiting'),
              Tab(text: 'Rejected'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ListView(
                  children: const [
                    ReservationsScreenListViewItem(
                      image: 'assets/images/my_photo.jpg',
                      city: 'Hebron',
                      status: 'Accepted',
                      name: 'Event Name',
                      time: '12:30',
                      date: '2022-03-09',
                    ),
                    ReservationsScreenListViewItem(
                      image: 'assets/images/my_photo.jpg',
                      city: 'Hebron',
                      status: 'Waiting',
                      name: 'Event Name',
                      time: '12:30',
                      date: '2022-03-09',
                    ),
                    ReservationsScreenListViewItem(
                      image: 'assets/images/my_photo.jpg',
                      city: 'Hebron',
                      status: 'Rejected',
                      name: 'Event Name',
                      time: '12:30',
                      date: '2022-03-09',
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.all(20),
                child: ListView(
                  children: const [
                    ReservationsScreenListViewItem(
                      image: 'assets/images/my_photo.jpg',
                      city: 'Hebron',
                      status: 'Accepted',
                      name: 'Event Name',
                      time: '12:30',
                      date: '2022-03-09',
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ListView(
                  children: const [
                    ReservationsScreenListViewItem(
                      image: 'assets/images/my_photo.jpg',
                      city: 'Hebron',
                      status: 'Waiting',
                      name: 'Event Name',
                      time: '12:30',
                      date: '2022-03-09',
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ListView(
                  children: const [
                    ReservationsScreenListViewItem(
                      image: 'assets/images/my_photo.jpg',
                      city: 'Hebron',
                      status: 'Rejected',
                      name: 'Event Name',
                      time: '12:30',
                      date: '2022-03-09',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
