import 'package:Rehlati/FireBase/fb_firestore_orders_controller.dart';
import 'package:Rehlati/Providers/profile_provider.dart';
import 'package:Rehlati/Screens/reservation_screen.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:Rehlati/widgets/Reservations%20Screen%20Widgets/reservations_screen_list_view_item.dart';
import 'package:Rehlati/widgets/not_logged_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

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
      child: reservationsWidget(),
    );
  }

  Widget reservationsWidget() {
    if (Provider.of<ProfileProvider>(context).loggedIn_) {
      return Scaffold(
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
            tabs: [
              Tab(text: AppLocalizations.of(context)!.all),
              Tab(text: AppLocalizations.of(context)!.waiting),
              Tab(text: AppLocalizations.of(context)!.accepted),
              Tab(text: AppLocalizations.of(context)!.rejected),
            ],
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: stream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> allReservations = snapshot.data!.docs;
              List<QueryDocumentSnapshot> waitingReservations = [];
              List<QueryDocumentSnapshot> acceptedReservations = [];
              List<QueryDocumentSnapshot> rejectedReservations = [];
              for (int i = 0; i < allReservations.length; i++) {
                if (allReservations[i].get('status') == 'waiting') {
                  waitingReservations.add(allReservations[i]);
                } else if (allReservations[i].get('status') == 'accepted') {
                  acceptedReservations.add(allReservations[i]);
                } else if (allReservations[i].get('status') == 'rejected') {
                  rejectedReservations.add(allReservations[i]);
                }
              }
              return TabBarView(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: ListView.builder(
                        itemCount: allReservations.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReservationScreen(
                                    tripName:
                                        allReservations[index].get('tripName'),
                                    tripTime:
                                        allReservations[index].get('tripTime'),
                                    tripDate:
                                        allReservations[index].get('tripDate'),
                                    tripAddressId:
                                        allReservations[index].get('cityId'),
                                    tripAddress: allReservations[index]
                                        .get('addressCityName'),
                                    tripAddressAr: allReservations[index]
                                        .get('addressCityNameAr'),
                                    tripId:
                                        allReservations[index].get('tripId'),
                                    firstPayment: allReservations[index]
                                        .get('firstPayment'),
                                    leftPayment: allReservations[index]
                                        .get('leftPayment'),
                                    officeName: allReservations[index]
                                        .get('officeName'),
                                    officeEmail: allReservations[index]
                                        .get('officeEmail'),
                                    officeId:
                                        allReservations[index].get('officeId'),
                                    userId:
                                        allReservations[index].get('userId'),
                                    userName:
                                        allReservations[index].get('userName'),
                                    userMobile: allReservations[index]
                                        .get('userMobile'),
                                    userDocId:
                                        allReservations[index].get('userDocId'),
                                    userEmail:
                                        allReservations[index].get('userEmail'),
                                    userAge:
                                        allReservations[index].get('userAge'),
                                    userGender: allReservations[index]
                                        .get('userGender'),
                                    fullPaid:
                                        allReservations[index].get('fullPaid'),
                                    status:
                                        allReservations[index].get('status'),
                                    noOfPeople: allReservations[index]
                                        .get('noOfPeople'),
                                    userNote:
                                        allReservations[index].get('userNote'),
                                    officeNote: allReservations[index]
                                        .get('officeNote'),
                                    orderId:
                                        allReservations[index].get('orderId'),
                                  ),
                                ),
                              );
                            },
                            child: ReservationsScreenListViewItem(
                              image: allReservations[index].get('tripImage'),
                              city: SharedPrefController().getLang == 'en'
                                  ? allReservations[index]
                                      .get('addressCityName')
                                  : allReservations[index]
                                      .get('addressCityNameAr'),
                              status: allReservations[index].get('status'),
                              name: allReservations[index].get('tripName'),
                              time: allReservations[index].get('tripTime'),
                              date: allReservations[index].get('tripDate'),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: waitingReservations.isNotEmpty
                          ? ListView.builder(
                              itemCount: waitingReservations.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReservationScreen(
                                          tripName: waitingReservations[index]
                                              .get('tripName'),
                                          tripTime: waitingReservations[index]
                                              .get('tripTime'),
                                          tripDate: waitingReservations[index]
                                              .get('tripDate'),
                                          tripAddressId:
                                              waitingReservations[index]
                                                  .get('cityId'),
                                          tripAddress:
                                              waitingReservations[index]
                                                  .get('addressCityName'),
                                          tripAddressAr:
                                              waitingReservations[index]
                                                  .get('addressCityNameAr'),
                                          tripId: waitingReservations[index]
                                              .get('tripId'),
                                          firstPayment:
                                              waitingReservations[index]
                                                  .get('firstPayment'),
                                          leftPayment:
                                              waitingReservations[index]
                                                  .get('leftPayment'),
                                          officeName: waitingReservations[index]
                                              .get('officeName'),
                                          officeEmail:
                                              waitingReservations[index]
                                                  .get('officeEmail'),
                                          officeId: waitingReservations[index]
                                              .get('officeId'),
                                          userId: waitingReservations[index]
                                              .get('userId'),
                                          userName: waitingReservations[index]
                                              .get('userName'),
                                          userMobile: waitingReservations[index]
                                              .get('userMobile'),
                                          userDocId: waitingReservations[index]
                                              .get('userDocId'),
                                          userEmail: waitingReservations[index]
                                              .get('userEmail'),
                                          userAge: waitingReservations[index]
                                              .get('userAge'),
                                          userGender: waitingReservations[index]
                                              .get('userGender'),
                                          fullPaid: waitingReservations[index]
                                              .get('fullPaid'),
                                          status: waitingReservations[index]
                                              .get('status'),
                                          noOfPeople: waitingReservations[index]
                                              .get('noOfPeople'),
                                          userNote: waitingReservations[index]
                                              .get('userNote'),
                                          officeNote: waitingReservations[index]
                                              .get('officeNote'),
                                          orderId: waitingReservations[index]
                                              .get('orderId'),
                                        ),
                                      ),
                                    );
                                  },
                                  child: ReservationsScreenListViewItem(
                                    image: waitingReservations[index]
                                        .get('tripImage'),
                                    city: SharedPrefController().getLang == 'en'
                                        ? waitingReservations[index]
                                            .get('addressCityName')
                                        : waitingReservations[index]
                                            .get('addressCityNameAr'),
                                    status: waitingReservations[index]
                                        .get('status'),
                                    name: waitingReservations[index]
                                        .get('tripName'),
                                    time: waitingReservations[index]
                                        .get('orderTime'),
                                    date: waitingReservations[index]
                                        .get('orderDate'),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                noReservations(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: acceptedReservations.isNotEmpty
                          ? ListView.builder(
                              itemCount: acceptedReservations.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReservationScreen(
                                          tripName: acceptedReservations[index]
                                              .get('tripName'),
                                          tripTime: acceptedReservations[index]
                                              .get('tripTime'),
                                          tripDate: acceptedReservations[index]
                                              .get('tripDate'),
                                          tripAddressId:
                                              acceptedReservations[index]
                                                  .get('cityId'),
                                          tripAddress:
                                              acceptedReservations[index]
                                                  .get('addressCityName'),
                                          tripAddressAr:
                                              acceptedReservations[index]
                                                  .get('addressCityNameAr'),
                                          tripId: acceptedReservations[index]
                                              .get('tripId'),
                                          firstPayment:
                                              acceptedReservations[index]
                                                  .get('firstPayment'),
                                          leftPayment:
                                              acceptedReservations[index]
                                                  .get('leftPayment'),
                                          officeName:
                                              acceptedReservations[index]
                                                  .get('officeName'),
                                          officeEmail:
                                              acceptedReservations[index]
                                                  .get('officeEmail'),
                                          officeId: acceptedReservations[index]
                                              .get('officeId'),
                                          userId: acceptedReservations[index]
                                              .get('userId'),
                                          userName: acceptedReservations[index]
                                              .get('userName'),
                                          userMobile:
                                              acceptedReservations[index]
                                                  .get('userMobile'),
                                          userDocId: acceptedReservations[index]
                                              .get('userDocId'),
                                          userEmail: acceptedReservations[index]
                                              .get('userEmail'),
                                          userAge: acceptedReservations[index]
                                              .get('userAge'),
                                          userGender:
                                              acceptedReservations[index]
                                                  .get('userGender'),
                                          fullPaid: acceptedReservations[index]
                                              .get('fullPaid'),
                                          status: acceptedReservations[index]
                                              .get('status'),
                                          noOfPeople:
                                              acceptedReservations[index]
                                                  .get('noOfPeople'),
                                          userNote: acceptedReservations[index]
                                              .get('userNote'),
                                          officeNote:
                                              acceptedReservations[index]
                                                  .get('officeNote'),
                                          orderId: acceptedReservations[index]
                                              .get('orderId'),
                                        ),
                                      ),
                                    );
                                  },
                                  child: ReservationsScreenListViewItem(
                                    image: acceptedReservations[index]
                                        .get('tripImage'),
                                    city: SharedPrefController().getLang == 'en'
                                        ? acceptedReservations[index]
                                            .get('addressCityName')
                                        : acceptedReservations[index]
                                            .get('addressCityNameAr'),
                                    status: acceptedReservations[index]
                                        .get('status'),
                                    name: acceptedReservations[index]
                                        .get('tripName'),
                                    time: acceptedReservations[index]
                                        .get('orderTime'),
                                    date: acceptedReservations[index]
                                        .get('orderDate'),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                noReservations(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: rejectedReservations.isNotEmpty
                          ? ListView.builder(
                              itemCount: rejectedReservations.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ReservationScreen(
                                          tripName: rejectedReservations[index]
                                              .get('tripName'),
                                          tripTime: rejectedReservations[index]
                                              .get('tripTime'),
                                          tripDate: rejectedReservations[index]
                                              .get('tripDate'),
                                          tripAddressId:
                                              rejectedReservations[index]
                                                  .get('cityId'),
                                          tripAddress:
                                              rejectedReservations[index]
                                                  .get('addressCityName'),
                                          tripAddressAr:
                                              rejectedReservations[index]
                                                  .get('addressCityNameAr'),
                                          tripId: rejectedReservations[index]
                                              .get('tripId'),
                                          firstPayment:
                                              rejectedReservations[index]
                                                  .get('firstPayment'),
                                          leftPayment:
                                              rejectedReservations[index]
                                                  .get('leftPayment'),
                                          officeName:
                                              rejectedReservations[index]
                                                  .get('officeName'),
                                          officeEmail:
                                              rejectedReservations[index]
                                                  .get('officeEmail'),
                                          officeId: rejectedReservations[index]
                                              .get('officeId'),
                                          userId: rejectedReservations[index]
                                              .get('userId'),
                                          userName: rejectedReservations[index]
                                              .get('userName'),
                                          userMobile:
                                              rejectedReservations[index]
                                                  .get('userMobile'),
                                          userDocId: rejectedReservations[index]
                                              .get('userDocId'),
                                          userEmail: rejectedReservations[index]
                                              .get('userEmail'),
                                          userAge: rejectedReservations[index]
                                              .get('userAge'),
                                          userGender:
                                              rejectedReservations[index]
                                                  .get('userGender'),
                                          fullPaid: rejectedReservations[index]
                                              .get('fullPaid'),
                                          status: rejectedReservations[index]
                                              .get('status'),
                                          noOfPeople:
                                              rejectedReservations[index]
                                                  .get('noOfPeople'),
                                          userNote: rejectedReservations[index]
                                              .get('userNote'),
                                          officeNote:
                                              rejectedReservations[index]
                                                  .get('officeNote'),
                                          orderId: rejectedReservations[index]
                                              .get('orderId'),
                                        ),
                                      ),
                                    );
                                  },
                                  child: ReservationsScreenListViewItem(
                                    image: rejectedReservations[index]
                                        .get('tripImage'),
                                    city: SharedPrefController().getLang == 'en'
                                        ? rejectedReservations[index]
                                            .get('addressCityName')
                                        : rejectedReservations[index]
                                            .get('addressCityNameAr'),
                                    status: rejectedReservations[index]
                                        .get('status'),
                                    name: rejectedReservations[index]
                                        .get('tripName'),
                                    time: rejectedReservations[index]
                                        .get('orderTime'),
                                    date: rejectedReservations[index]
                                        .get('orderDate'),
                                  ),
                                );
                              },
                            )
                          : Center(
                              child: Text(
                                noReservations(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  noReservations(),
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
      );
    } else {
      return const Scaffold(body: NotLoggedIn());
    }
  }

  Stream<QuerySnapshot> stream() {
    if (SharedPrefController().getAccountType == 'user') {
      return FbFireStoreOrdersController().readUserReservations();
    } else if (SharedPrefController().getAccountType == 'office') {
      return FbFireStoreOrdersController().readOfficeOrders();
    } else {
      return FbFireStoreOrdersController().readAllReservationsForAdmin();
    }
  }

  String noReservations() {
    if (SharedPrefController().getAccountType == 'office') {
      return AppLocalizations.of(context)!.noReservations;
    } else {
      return AppLocalizations.of(context)!.noReservations;
    }
  }
}
