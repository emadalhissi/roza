import 'dart:math';
import 'package:Rehlati/FireBase/fb_firestore_offices_controller.dart';
import 'package:Rehlati/FireBase/fb_firestore_orders_controller.dart';
import 'package:Rehlati/FireBase/fb_firestore_trips_controller.dart';
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
  final String? space;

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
    required this.space,
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
  late TextEditingController userNoteEditingController;

  late TextEditingController malesEditingController;
  late TextEditingController femalesEditingController;
  late TextEditingController childrenEditingController;

  var random = Random().nextInt(1000000);

  bool loading = false;

  bool malesCheckbox = false;
  bool femalesCheckbox = false;
  bool childrenCheckbox = false;

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
    userNoteEditingController = TextEditingController();
    malesEditingController = TextEditingController(text: '0');
    femalesEditingController = TextEditingController(text: '0');
    childrenEditingController = TextEditingController(text: '0');
  }

  @override
  void dispose() {
    fullNameEditingController.dispose();
    mobileEditingController.dispose();
    userDocIdEditingController.dispose();
    userEmailEditingController.dispose();
    userAgeEditingController.dispose();
    firstPaymentEditingController.dispose();
    userNoteEditingController.dispose();
    malesEditingController.dispose();
    femalesEditingController.dispose();
    childrenEditingController.dispose();
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
                              widget.time!,
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
                              AppLocalizations.of(context)!.leftNumber +
                                  ': ' +
                                  widget.space!,
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
              widget.space != '0'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                          textEditingController: userAgeEditingController,
                          hint: AppLocalizations.of(context)!.age,
                          textInputType: TextInputType.number,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: malesCheckbox,
                              activeColor: const Color(0xff5859F3),
                              onChanged: (newValue) {
                                setState(() {
                                  malesCheckbox = newValue!;
                                  malesEditingController.text = '0';
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.males,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: malesCheckbox
                                  ? SizedBox(
                                      height: 55,
                                      child: TextField(
                                        controller: malesEditingController,
                                        keyboardType: TextInputType.number,
                                        enabled: malesCheckbox,
                                        decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .number,
                                          suffixIconColor:
                                              const Color(0xff8E8E93),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xffB9B9BB),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Colors.black45,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xff63CEDA),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xffFF4343),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(height: 55),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: femalesCheckbox,
                              activeColor: const Color(0xff5859F3),
                              onChanged: (newValue) {
                                setState(() {
                                  femalesCheckbox = newValue!;
                                  femalesEditingController.text = '0';
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.females,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: femalesCheckbox
                                  ? SizedBox(
                                      height: 55,
                                      child: TextField(
                                        controller: femalesEditingController,
                                        keyboardType: TextInputType.number,
                                        enabled: femalesCheckbox,
                                        decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .number,
                                          suffixIconColor:
                                              const Color(0xff8E8E93),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xffB9B9BB),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Colors.black45,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xff63CEDA),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xffFF4343),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(height: 55),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: childrenCheckbox,
                              activeColor: const Color(0xff5859F3),
                              onChanged: (newValue) {
                                setState(() {
                                  childrenCheckbox = newValue!;
                                  childrenEditingController.text = '0';
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                AppLocalizations.of(context)!.children,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              child: childrenCheckbox
                                  ? SizedBox(
                                      height: 55,
                                      child: TextField(
                                        controller: childrenEditingController,
                                        keyboardType: TextInputType.number,
                                        enabled: childrenCheckbox,
                                        decoration: InputDecoration(
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .number,
                                          suffixIconColor:
                                              const Color(0xff8E8E93),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xffB9B9BB),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          disabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Colors.black45,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xff63CEDA),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              width: 1,
                                              color: Color(0xffFF4343),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(height: 55),
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
                                  child: CircularProgressIndicator(
                                      color: Colors.white),
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
                    )
                  : Center(
                      child: Text(
                        AppLocalizations.of(context)!.cantBeOrdered,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  int countNumberOfPeople() {
    int males = int.parse(malesEditingController.text);
    int females = int.parse(femalesEditingController.text);
    int children = int.parse(childrenEditingController.text);
    int sum = males + females + children;
    return sum;
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
    await updateSpace();
    setState(() {
      loading = false;
    });
    Navigator.pop(context);
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

  Future<void> updateSpace() async {
    int oldSpace = int.parse(widget.space!);
    int newSpace = oldSpace - countNumberOfPeople();

    await FbFireStoreTripsController().updateTripSpace(
      officeUId: widget.officeId!,
      tripId: widget.tripId!,
      newSpace: '$newSpace',
      addressCityName: widget.addressCityName!,
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
    } else if ((!malesCheckbox && !femalesCheckbox && !childrenCheckbox) ||
        countNumberOfPeople() == 0) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterAtLeastOnePerson,
        error: true,
      );
      return false;
    } else if (malesCheckbox && malesEditingController.text == '0') {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterNoOfMales,
        error: true,
      );
      return false;
    } else if (femalesCheckbox && femalesEditingController.text == '0') {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterNoOfFemales,
        error: true,
      );
      return false;
    } else if (childrenCheckbox && childrenEditingController.text == '0') {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterNoOfChildren,
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
    } else if (countNumberOfPeople() > int.parse(widget.space!)) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.numberOfPeopleMoreThanLeftNumber,
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
      noOfPeople: countNumberOfPeople().toString(),
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
      males: malesEditingController.text.toString(),
      females: femalesEditingController.text.toString(),
      children: childrenEditingController.text.toString(),
    );
    return trip;
  }
}
