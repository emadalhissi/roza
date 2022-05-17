import 'dart:math';
import 'package:Rehlati/FireBase/fb_firestore_offices_controller.dart';
import 'package:Rehlati/FireBase/fb_firestore_orders_controller.dart';
import 'package:Rehlati/FireBase/fb_firestore_users_controller.dart';
import 'package:Rehlati/helpers/snack_bar.dart';
import 'package:Rehlati/models/order.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:Rehlati/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  late TextEditingController userEmailEditingController;
  late TextEditingController userAgeEditingController;
  late TextEditingController firstPaymentEditingController;
  late TextEditingController noOfPeopleEditingController;
  late TextEditingController userNoteEditingController;

  var random = Random().nextInt(1000000);

  bool loading = false;

  int gender = -1;

  @override
  void initState() {
    super.initState();
    fullNameEditingController =
        TextEditingController(text: SharedPrefController().getFullName);
    mobileEditingController =
        TextEditingController(text: SharedPrefController().getMobile);
    userDocIdEditingController = TextEditingController();
    userEmailEditingController =
        TextEditingController(text: SharedPrefController().getEmail);
    userAgeEditingController = TextEditingController();
    firstPaymentEditingController = TextEditingController();
    noOfPeopleEditingController = TextEditingController();
    userNoteEditingController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameEditingController.dispose();
    mobileEditingController.dispose();
    userDocIdEditingController.dispose();
    userEmailEditingController.dispose();
    userAgeEditingController.dispose();
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
              Text(
                AppLocalizations.of(context)!.tripDetails,
                style: const TextStyle(
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
                              '${AppLocalizations.of(context)!.minPayment}: ${widget.minPayment!}',
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
                AppLocalizations.of(context)!.orderInfo,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: fullNameEditingController,
                hint: AppLocalizations.of(context)!.fullName,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: userDocIdEditingController,
                hint: AppLocalizations.of(context)!.docIdNo,
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: mobileEditingController,
                hint: AppLocalizations.of(context)!.mobileNumber,
                textInputType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: userEmailEditingController,
                hint: AppLocalizations.of(context)!.email +
                    ' ${AppLocalizations.of(context)!.optional}',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: noOfPeopleEditingController,
                hint: AppLocalizations.of(context)!.noOfPeople,
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: userAgeEditingController,
                hint: AppLocalizations.of(context)!.age,
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      leading: Radio(
                        value: 0,
                        groupValue: gender,
                        activeColor: const Color(0xff5859F3),
                        onChanged: (int? newValue) {
                          setState(() {
                            gender = newValue!;
                          });
                        },
                      ),
                      title: Text(AppLocalizations.of(context)!.male),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      leading: Radio(
                        value: 1,
                        groupValue: gender,
                        activeColor: const Color(0xff5859F3),
                        onChanged: (int? newValue) {
                          setState(() {
                            gender = newValue!;
                          });
                        },
                      ),
                      title: Text(AppLocalizations.of(context)!.female),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.paymentDetails,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: firstPaymentEditingController,
                hint:
                    '${AppLocalizations.of(context)!.minPayment}: ${widget.minPayment}',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.otherDetails,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: userNoteEditingController,
                hint: AppLocalizations.of(context)!.optionalNotes,
                lines: 3,
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Text(
                        AppLocalizations.of(context)!.addReservation,
                        style: const TextStyle(
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
    await updateBalance();
    setState(() {
      loading = false;
    });
    Navigator.pop(context);
  }

  Future<void> updateBalance() async {
    int oldUserBalance = await FbFireStoreUsersController()
        .getUserBalance(uId: SharedPrefController().getUId);
    int oldOfficeBalance = await FbFireStoreOfficesController()
        .getOfficeBalance(uId: widget.officeId!);

    int newUserBalance =
        oldUserBalance - int.parse(firstPaymentEditingController.text);
    int newOfficeBalance =
        oldOfficeBalance + int.parse(firstPaymentEditingController.text);

    await FbFireStoreUsersController().updateBalance(
      uId: SharedPrefController().getUId,
      balance: newUserBalance,
    );
    await FbFireStoreOfficesController().updateBalance(
      uId: widget.officeId!,
      balance: newOfficeBalance,
    );
  }

  bool checkData() {
    if (fullNameEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterFullName,
        error: true,
      );
      return false;
    } else if (userDocIdEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterDocId,
        error: true,
      );
      return false;
    } else if (mobileEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterMobile,
        error: true,
      );
      return false;
    } else if (userAgeEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterAge,
        error: true,
      );
      return false;
    } else if (gender == -1) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.chooseGender,
        error: true,
      );
      return false;
    } else if (firstPaymentEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterFirstPayment,
        error: true,
      );
      return false;
    } else if (num.parse(firstPaymentEditingController.text.toString()) <
        num.parse(widget.minPayment!)) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!
            .firstPaymentCantBeLessThanTripMinPayment,
        error: true,
      );
      return false;
    } else if (num.parse(firstPaymentEditingController.text.toString()) >
        num.parse(widget.price!)) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!
            .firstPaymentCantBeGreaterThanTripPrice,
        error: true,
      );
      return false;
    } else if (noOfPeopleEditingController.text.isEmpty ||
        noOfPeopleEditingController.text.toString() == '0') {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterNoOfPeople,
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
      userEmail: userEmailEditingController.text.toString(),
      userAge: int.parse(userAgeEditingController.text.toString()),
      userGender: gender,
    );
    return trip;
  }
}
