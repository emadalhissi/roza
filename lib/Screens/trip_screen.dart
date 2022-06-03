import 'package:Rehlati/FireBase/fb_firestore_favorites_controller.dart';
import 'package:Rehlati/Providers/favorites_provider.dart';
import 'package:Rehlati/Providers/profile_provider.dart';
import 'package:Rehlati/Screens/User%20Screens/add_reservation_screen.dart';
import 'package:Rehlati/helpers/snack_bar.dart';
import 'package:Rehlati/models/order.dart';
import 'package:Rehlati/models/trip.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TripScreen extends StatefulWidget {
  final String tripName;
  final String tripTime;
  final String tripDate;
  final int tripAddressId;
  final String tripAddress;
  final String tripAddressAr;
  final String price;
  final String tripId;
  final String tripDescription;
  final String minPayment;
  final List<dynamic> tripImages;
  final String officeName;
  final String officeEmail;
  final String officeId;
  final bool isAdmin;
  final String space;

  const TripScreen({
    required this.tripName,
    required this.tripTime,
    required this.tripDate,
    required this.tripAddressId,
    required this.tripAddress,
    required this.tripAddressAr,
    required this.price,
    required this.tripId,
    required this.tripDescription,
    required this.minPayment,
    required this.tripImages,
    required this.officeName,
    required this.officeEmail,
    required this.officeId,
    this.isAdmin = false,
    required this.space,
    Key? key,
  }) : super(key: key);

  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> with SnackBarHelper {
  String noOfOrders = '0';

  @override
  void initState() {
    super.initState();
    getTripOrders();
  }

  Future<void> getTripOrders() async {
    List<Order> orders = [];
    var ordersFromFirebase = await FirebaseFirestore.instance
        .collection('cities')
        .doc(widget.tripAddress)
        .collection('trips')
        .doc(widget.tripId)
        .collection('orders')
        .get();

    if (ordersFromFirebase.docs.isNotEmpty) {
      for (var doc in ordersFromFirebase.docs) {
        orders.add(Order.fromMap(doc.data()));
      }
      setState(() {
        noOfOrders = orders.length.toString();
      });
    }
  }

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
        title: Text(
          AppLocalizations.of(context)!.back,
          style: const TextStyle(
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
                      autoPlay: widget.tripImages.length == 1 ? false : true,
                      height: 350,
                      viewportFraction: 1,
                    ),
                    items: widget.tripImages
                        .map(
                          (image) => Container(
                            height: 350,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  noOfOrders != '0'
                      ? PositionedDirectional(
                          bottom: 5,
                          end: 15,
                          child: Chip(
                            label: Text(
                              AppLocalizations.of(context)!.noOfOrders +
                                  noOfOrders,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            backgroundColor:
                                const Color(0xff5859F3).withOpacity(0.40),
                          ),
                        )
                      : const SizedBox.shrink(),
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
                            widget.tripName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '\$${widget.price}',
                            style: const TextStyle(
                              color: Color(0xff5859F3),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Provider.of<ProfileProvider>(context).loggedIn_
                          ? favoriteOption()
                          : const SizedBox.shrink(),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Table(
                    children: [
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.timer,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  widget.tripTime,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
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
                                widget.tripDate,
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.place,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  SharedPrefController().getLang == 'en'
                                      ? widget.tripAddress
                                      : widget.tripAddressAr,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.attach_money,
                                color: Colors.grey,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  '${AppLocalizations.of(context)!.minPayment}: \$${widget.minPayment}',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.people,
                                  color: Colors.deepOrange,
                                  size: 20,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  AppLocalizations.of(context)!.leftNumber + ': ' + widget.space,
                                  style: const TextStyle(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.tripDetails,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.tripDescription,
                    style: const TextStyle(
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
      bottomNavigationBar: bottomNavigation(),
    );
  }

  Widget bottomNavigation() {
    if (widget.isAdmin || SharedPrefController().getAccountType == 'office') {
      return const SizedBox.shrink();
    } else {
      return ElevatedButton(
        child: Text(
          AppLocalizations.of(context)!.order,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if (Provider.of<ProfileProvider>(context, listen: false).loggedIn_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddReservationScreen(
                  tripId: widget.tripId,
                  tripName: widget.tripName,
                  addressCityId: widget.tripAddressId,
                  addressCityName: widget.tripAddress,
                  addressCityNameAr: widget.tripAddressAr,
                  time: widget.tripTime,
                  date: widget.tripDate,
                  price: widget.price,
                  minPayment: widget.minPayment,
                  officeName: widget.officeName,
                  officeEmail: widget.officeEmail,
                  officeId: widget.officeId,
                  tripImage: widget.tripImages[0],
                  space: widget.space,
                ),
              ),
            );
          } else {
            showSnackBar(
              context,
              message: AppLocalizations.of(context)!.pleaseLogin,
              error: true,
            );
          }
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
      );
    }
  }

  Widget favoriteOption() {
    if (SharedPrefController().getAccountType == 'admin' ||
        (SharedPrefController().getAccountType == 'office' &&
            widget.officeId == SharedPrefController().getUId)) {
      return const SizedBox.shrink();
    } else {
      return InkWell(
        onTap: () async {
          await favorite();
        },
        child: CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          radius: 23,
          child: Icon(
            Icons.favorite,
            color: Provider.of<FavoritesProvider>(context)
                    .checkFavorite(tripId: widget.tripId)
                ? const Color(0xff5859F3)
                : Colors.white,
          ),
        ),
      );
    }
  }

  Future<void> favorite() async {
    await FbFireStoreFavoritesController().favorite(
      type: SharedPrefController().getAccountType,
      tripId: widget.tripId,
      officeId: widget.officeId,
      callBackUrl: ({
        required bool status,
        required bool favorite,
        required Trip trip,
      }) async {
        if (status && favorite) {
          Provider.of<FavoritesProvider>(context, listen: false).favorite_(
            trip: trip,
            status: true,
          );
          showSnackBar(
            context,
            message: AppLocalizations.of(context)!.favoriteAdded,
            error: false,
          );
        } else if (status && !favorite) {
          Provider.of<FavoritesProvider>(context, listen: false).favorite_(
            trip: trip,
            status: false,
          );
          showSnackBar(
            context,
            message: AppLocalizations.of(context)!.favoriteRemoved,
            error: false,
          );
        } else {
          showSnackBar(
            context,
            message: AppLocalizations.of(context)!.somethingWentWrong,
            error: true,
          );
        }
      },
    );
  }
}
