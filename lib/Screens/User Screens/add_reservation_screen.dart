import 'dart:math';

import 'package:Rehlati/FireBase/fb_firestore_orders_controller.dart';
import 'package:Rehlati/helpers/snack_bar.dart';
import 'package:Rehlati/models/order.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:Rehlati/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class AddReservationScreen extends StatefulWidget {
  final String? tripId;
  final String? tripName;
  final String? tripImage;
  final String? time;
  final String? date;
  final int? addressCityId;
  final String? addressCityName;
  final String? addressCityNameAr;
  final String? price;
  final String? minPayment;
  final String? officeEmail;
  final String? officeName;
  final String? officeId;

  const AddReservationScreen({
    required this.tripId,
    required this.tripName,
    required this.tripImage,
    required this.time,
    required this.date,
    required this.addressCityId,
    required this.addressCityName,
    required this.addressCityNameAr,
    required this.price,
    required this.minPayment,
    required this.officeEmail,
    required this.officeName,
    required this.officeId,
    Key? key,
  }) : super(key: key);

  @override
  _AddReservationScreenState createState() => _AddReservationScreenState();
}

class _AddReservationScreenState extends State<AddReservationScreen>
    with SnackBarHelper {
  late TextEditingController fullNameEditingController;
  late TextEditingController mobileEditingController;
  late TextEditingController userDocIdEditingController;
  late TextEditingController firstPaymentEditingController;
  late TextEditingController noOfPeopleEditingController;
  late TextEditingController userNoteEditingController;

  var random = Random().nextInt(1000000);

  bool loading = false;

  @override
  void initState() {
    super.initState();
    fullNameEditingController =
        TextEditingController(text: SharedPrefController().getFullName);
    mobileEditingController =
        TextEditingController(text: SharedPrefController().getMobile);
    userDocIdEditingController = TextEditingController();
    firstPaymentEditingController = TextEditingController();
    noOfPeopleEditingController = TextEditingController();
    userNoteEditingController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameEditingController.dispose();
    mobileEditingController.dispose();
    userDocIdEditingController.dispose();
    firstPaymentEditingController.dispose();
    noOfPeopleEditingController.dispose();
    userNoteEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        centerTitle: true,
        title: Text(
          widget.tripName!,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Trip Details',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Table(
                children: [
                  TableRow(
                    children: [
                      Text(
                        '\$${widget.price!}',
                        style: const TextStyle(
                          color: Color(0xff5859F3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.officeName!,
                        style: const TextStyle(
                          color: Color(0xff5859F3),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ],
                  ),
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
                            widget.time!,
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
                            widget.date!,
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
                                ? widget.addressCityName!
                                : widget.addressCityNameAr!,
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
                              'Min. Payment: \$${widget.minPayment!}',
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
              const Text(
                'Your Details',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: fullNameEditingController,
                hint: 'Your Name',
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: userDocIdEditingController,
                hint: 'Document ID #',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: mobileEditingController,
                hint: 'Your Mobile',
                textInputType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              const Text(
                'Payment Details',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: firstPaymentEditingController,
                hint: 'Min. Payment: ${widget.minPayment}',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              const Text(
                'Other Details',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: noOfPeopleEditingController,
                hint: '# of People',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: userNoteEditingController,
                hint: 'Notes (Optional)',
                lines: 3,
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : const Text(
                        'Add Reservation',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                onPressed: () async {
                  await performAddReservation();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  padding: EdgeInsets.zero,
                  primary: const Color(0xff5859F3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> performAddReservation() async {
    if (checkData()) {
      await addReservation();
    }
  }

  Future<void> addReservation() async {
    setState(() {
      loading = true;
    });
    await FbFireStoreOrdersController().createOrder(order: order);
    setState(() {
      loading = false;
    });
    Navigator.pop(context);
  }

  bool checkData() {
    if (fullNameEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: 'Enter Your Name!',
        error: true,
      );
      return false;
    } else if (userDocIdEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: 'Enter Your Document ID!',
        error: true,
      );
      return false;
    } else if (mobileEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: 'Enter Your Mobile Number!',
        error: true,
      );
      return false;
    } else if (firstPaymentEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: 'Enter First Payment!',
        error: true,
      );
      return false;
    } else if (num.parse(firstPaymentEditingController.text.toString()) <
        num.parse(widget.minPayment!)) {
      showSnackBar(
        context,
        message: 'First Payment Con\'nt Be Less Than Trip Min. Payment!',
        error: true,
      );
      return false;
    } else if (num.parse(firstPaymentEditingController.text.toString()) >
        num.parse(widget.price!)) {
      showSnackBar(
        context,
        message: 'First Payment Con\'nt Be Greater Than Trip Price!',
        error: true,
      );
      return false;
    } else if (noOfPeopleEditingController.text.isEmpty ||
        noOfPeopleEditingController.text.toString() == '0') {
      showSnackBar(
        context,
        message: 'Enter No. of People!',
        error: true,
      );
      return false;
    }
    return true;
  }

  String createOrderId() {
    String dateTimeNow =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    return '$random-$dateTimeNow-${SharedPrefController().getUId}';
  }

  Order get order {
    Order trip = Order(
      orderId: createOrderId(),
      orderTime: '${DateTime.now().hour}:${DateTime.now().minute}',
      orderDate:
          '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
      tripId: widget.tripId,
      tripName: widget.tripName,
      tripImage: widget.tripImage,
      officeId: widget.officeId,
      officeName: widget.officeName,
      officeEmail: widget.officeEmail,
      cityId: widget.addressCityId,
      addressCityName: widget.addressCityName,
      addressCityNameAr: widget.addressCityNameAr,
      status: 'waiting',
      officeNote: '',
      userNote: userNoteEditingController.text.toString(),
      noOfPeople: noOfPeopleEditingController.text.toString(),
      firstPayment: int.parse(firstPaymentEditingController.text.toString()),
      leftPayment: int.parse(widget.price!) -
          int.parse(firstPaymentEditingController.text.toString()),
      fullPaid: int.parse(widget.price!) ==
          int.parse(firstPaymentEditingController.text.toString()),
      userName: fullNameEditingController.text.toString(),
      userMobile: mobileEditingController.text.toString(),
      userDocId: userDocIdEditingController.text.toString(),
      userId: SharedPrefController().getUId,
      tripDate: widget.date,
      tripTime: widget.time,
    );
    return trip;
  }
}
