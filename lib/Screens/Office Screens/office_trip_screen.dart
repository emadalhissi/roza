import 'package:Rehlati/FireBase/fb_firestore_favorites_controller.dart';
import 'package:Rehlati/FireBase/fb_firestore_notifications_controller.dart';
import 'package:Rehlati/FireBase/fb_firestore_offices_controller.dart';
import 'package:Rehlati/FireBase/fb_firestore_trips_controller.dart';
import 'package:Rehlati/FireBase/fb_firestore_users_controller.dart';
import 'package:Rehlati/Functions/sent_fire_base_message_from_server.dart';
import 'package:Rehlati/Providers/favorites_provider.dart';
import 'package:Rehlati/Screens/Office%20Screens/edit_trip_screen.dart';
import 'package:Rehlati/helpers/snack_bar.dart';
import 'package:Rehlati/models/notification.dart';
import 'package:Rehlati/models/order.dart';
import 'package:Rehlati/models/trip.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:Rehlati/widgets/app_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OfficeTripScreen extends StatefulWidget {
  final String tripName;
  final String tripTime;
  final String tripDate;
  final int tripCityId;
  final String tripAddress;
  final String tripAddressAr;
  final String price;
  final String tripId;
  final String tripDescription;
  final String minPayment;
  final List<dynamic> tripImages;
  final String officeId;
  final String number;
  final String space;

  const OfficeTripScreen({
    required this.tripName,
    required this.tripTime,
    required this.tripDate,
    required this.tripCityId,
    required this.tripAddress,
    required this.tripAddressAr,
    required this.price,
    required this.tripId,
    required this.tripDescription,
    required this.minPayment,
    required this.tripImages,
    required this.officeId,
    required this.number,
    required this.space,
    Key? key,
  }) : super(key: key);

  @override
  _OfficeTripScreenState createState() => _OfficeTripScreenState();
}

class _OfficeTripScreenState extends State<OfficeTripScreen>
    with SnackBarHelper {
  String noOfOrders = '0';

  late TextEditingController deleteReasonEditingController;

  @override
  void initState() {
    super.initState();
    deleteReasonEditingController = TextEditingController();
    getTripOrders();
  }

  @override
  void dispose() {
    deleteReasonEditingController.dispose();
    super.dispose();
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
                      favoriteOption(),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                                widget.tripTime,
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
                          Row(
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
                                  '${AppLocalizations.of(context)!.minPayment}: ${widget.minPayment}',
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
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  child: Text(
                    AppLocalizations.of(context)!.edit,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditTripScreen(
                          tripName: widget.tripName,
                          tripTime: widget.tripTime,
                          tripDate: widget.tripDate,
                          tripCityId: widget.tripCityId,
                          tripAddress: widget.tripAddress,
                          tripAddressAr: widget.tripAddressAr,
                          price: widget.price,
                          tripId: widget.tripId,
                          tripDescription: widget.tripDescription,
                          minPayment: widget.minPayment,
                          tripImages: widget.tripImages,
                          number: widget.number,
                          space: widget.space,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 70),
                    padding: EdgeInsets.zero,
                    primary: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  child: Text(
                    AppLocalizations.of(context)!.delete,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                  onPressed: () {
                    showDeleteTripAlertDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 70),
                    padding: EdgeInsets.zero,
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

  String createNotificationId() {
    String dateTimeNow =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}-${DateTime.now().millisecond}';
    return 'DeleteTripNotification:$dateTimeNow-${SharedPrefController().getUId}';
  }

  Future<void> deleteTrip() async {
    String messageTitle = 'حذف رحلة';
    String deleteMade = 'تم حذف الرحلة: ';
    String deleteMadeBy = ' من قبل المكتب ';
    String deleteReason = 'السبب: ';
    String messageBody = deleteMade +
        widget.tripName +
        deleteMadeBy +
        SharedPrefController().getFullName +
        ' - ' +
        deleteReason +
        deleteReasonEditingController.text;

    await updateBalance();

    await FbFireStoreNotificationsController().addNotificationToUsers(
      tripId: widget.tripId,
      notification: NotificationModel(
        notificationId: createNotificationId(),
        title: messageTitle,
        body: messageBody,
        reason: deleteReasonEditingController.text,
        timestamp: Timestamp.now(),
      ),
    );

    var fcmTokens = await FbFireStoreOfficesController()
        .getFcmTokensForTrip(tripId: widget.tripId);
    await SendFireBaseMessageFromServer().sentMessage(
      fcmTokens: fcmTokens,
      title: messageTitle,
      body: messageBody,
    );

    await FbFireStoreTripsController().deleteTrip(
      tripId: widget.tripId,
      tripCity: widget.tripAddress,
    );

    Navigator.pop(context);
  }

  Future<void> updateBalance() async {
    var idsAndFirstPayments = await FbFireStoreOfficesController()
        .getUserIdAndFirstPaymentForOrder(tripId: widget.tripId);
    for (int i = 0; i < idsAndFirstPayments.length; i++) {
      int oldUserBalance = await FbFireStoreUsersController()
          .getUserBalance(uId: idsAndFirstPayments[i].keys.single);
      int oldOfficeBalance = await FbFireStoreOfficesController()
          .getOfficeBalance(uId: SharedPrefController().getUId);
      int newUserBalance =
          oldUserBalance + idsAndFirstPayments[i].values.single;
      int newOfficeBalance =
          oldOfficeBalance - idsAndFirstPayments[i].values.single;

      await FbFireStoreUsersController().updateBalance(
        uId: idsAndFirstPayments[i].keys.single,
        balance: newUserBalance,
      );
      await FbFireStoreOfficesController().updateBalance(
        uId: SharedPrefController().getUId,
        balance: newOfficeBalance,
      );
    }
  }

  showDeleteTripAlertDialog(BuildContext context) {
    Widget cancelButton = TextButton(
      child: Text(
        AppLocalizations.of(context)!.no,
        style: const TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context, () {
          setState(() {});
        });
      },
    );
    Widget continueButton = TextButton(
      child: Text(
        AppLocalizations.of(context)!.yes,
        style: const TextStyle(color: Colors.black),
      ),
      onPressed: () async {
        Navigator.pop(context);
        showReasonAlertDialog(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(AppLocalizations.of(context)!.deleteTrip),
      content: Text(AppLocalizations.of(context)!.sureDeleteTrip),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showReasonAlertDialog(BuildContext context) {
    deleteReasonEditingController.text = '';
    Widget deleteButton = TextButton(
      child: Text(
        AppLocalizations.of(context)!.delete.toUpperCase(),
        style: const TextStyle(color: Colors.black),
      ),
      onPressed: () async {
        Navigator.pop(context);
        await deleteTrip();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(AppLocalizations.of(context)!.deleteReason),
      content: AppTextField(
        textEditingController: deleteReasonEditingController,
        hint: AppLocalizations.of(context)!.deleteReason,
        lines: 3,
      ),
      actions: [
        deleteButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
