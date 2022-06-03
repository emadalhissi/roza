import 'dart:io';
import 'package:Rehlati/FireBase/fb_firestore_notifications_controller.dart';
import 'package:Rehlati/FireBase/fb_firestore_offices_controller.dart';
import 'package:Rehlati/FireBase/fb_firestore_trips_controller.dart';
import 'package:Rehlati/FireBase/fb_storage_controller.dart';
import 'package:Rehlati/Functions/sent_fire_base_message_from_server.dart';
import 'package:Rehlati/helpers/snack_bar.dart';
import 'package:Rehlati/models/notification.dart';
import 'package:Rehlati/models/trip.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:Rehlati/widgets/app_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTripScreen extends StatefulWidget {
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
  final String number;
  final String space;

  const EditTripScreen({
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
    required this.number,
    required this.space,
    Key? key,
  }) : super(key: key);

  @override
  _EditTripScreenState createState() => _EditTripScreenState();
}

class _EditTripScreenState extends State<EditTripScreen> with SnackBarHelper {
  late TextEditingController tripNameEditingController;
  late TextEditingController tripDescriptionEditingController;
  late TextEditingController tripPriceEditingController;
  late TextEditingController tripMinPaymentEditingController;
  late TextEditingController numberOfPeopleEditingController;

  var imagePicker = ImagePicker();

  CollectionReference officesCollectionReference =
      FirebaseFirestore.instance.collection('offices');

  CollectionReference citiesCollectionReference =
      FirebaseFirestore.instance.collection('cities');

  CollectionReference officeTripsCollectionReference = FirebaseFirestore
      .instance
      .collection('offices')
      .doc(SharedPrefController().getUId)
      .collection('trips');

  late List<dynamic> oldTripImages = widget.tripImages;
  List<XFile>? newTripImages = [];

  bool loading = false;

  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();

  late String time_ = widget.tripTime;
  late String date_ = widget.tripDate;

  int imagesUploaded = 0;

  late String oldTripName = widget.tripName;

  @override
  void initState() {
    super.initState();
    tripNameEditingController = TextEditingController(text: widget.tripName);
    tripDescriptionEditingController =
        TextEditingController(text: widget.tripDescription);
    tripPriceEditingController = TextEditingController(text: widget.price);
    tripMinPaymentEditingController =
        TextEditingController(text: widget.minPayment);
    numberOfPeopleEditingController =
        TextEditingController(text: widget.number);
  }

  @override
  void dispose() {
    tripNameEditingController.dispose();
    tripDescriptionEditingController.dispose();
    tripPriceEditingController.dispose();
    tripMinPaymentEditingController.dispose();
    numberOfPeopleEditingController.dispose();
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
        title: const Text(
          'Edit Trip',
          style: TextStyle(
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
              const SizedBox(height: 20),
              AppTextField(
                textEditingController: tripNameEditingController,
                hint: AppLocalizations.of(context)!.tripName,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: tripPriceEditingController,
                hint: AppLocalizations.of(context)!.tripPrice,
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: tripMinPaymentEditingController,
                hint: AppLocalizations.of(context)!.minPayment,
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: numberOfPeopleEditingController,
                hint: AppLocalizations.of(context)!.noOfPeople,
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: tripDescriptionEditingController,
                hint: AppLocalizations.of(context)!.description,
                lines: 3,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        TimeOfDay? newTime = await showTimePicker(
                          context: context,
                          initialTime: time,
                        );
                        if (newTime == null) return;
                        setState(() {
                          time_ = '${newTime.hour}:${newTime.minute}';
                        });
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            time_,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: date,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2024),
                        );
                        if (newDate == null) return;
                        setState(() {
                          date_ =
                              '${newDate.year}-${newDate.month}-${newDate.day}';
                        });
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            date_,
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(context)!.tripImages,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  oldTripImages.isNotEmpty
                      ? InkWell(
                          onTap: () async {
                            await pickImage();
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(50),
                              border:
                                  Border.all(color: const Color(0xffDBDBDB)),
                            ),
                            child: const Center(
                              child: Icon(Icons.photo_camera),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              const SizedBox(height: 20),
              Wrap(
                runSpacing: 10,
                children: [
                  image(),
                  newTripImages!.isNotEmpty
                      ? GridView.builder(
                          itemCount: newTripImages!.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: FileImage(
                                    File(newTripImages![index].path),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  PositionedDirectional(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          newTripImages!.removeAt(index);
                                        });
                                      },
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 40,
                                      ),
                                    ),
                                    top: 5,
                                    end: 5,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : Text(
                        AppLocalizations.of(context)!.editTrip,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                onPressed: () async {
                  await performEditTrip();
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

  Widget image() {
    if (oldTripImages.isEmpty && newTripImages!.isEmpty) {
      return InkWell(
        onTap: () async {
          await pickImage();
        },
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: Colors.grey,
          strokeWidth: 1.5,
          radius: const Radius.circular(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: double.infinity,
              height: 150,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                      size: 50,
                    ),
                    Text(
                      AppLocalizations.of(context)!.addImage,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    } else if (oldTripImages.isNotEmpty) {
      return GridView.builder(
        itemCount: oldTripImages.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: CachedNetworkImageProvider(oldTripImages[index]),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                PositionedDirectional(
                  child: InkWell(
                    onTap: () {
                      showDeleteImageAlertDialog(
                        context,
                        index: index,
                        url: oldTripImages[index],
                      );
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                  top: 5,
                  end: 5,
                ),
              ],
            ),
          );
        },
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Future<void> performEditTrip() async {
    if (checkData()) {
      await editTrip();
    }
  }

  bool checkData() {
    if (tripNameEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterTripName,
        error: true,
      );
      return false;
    } else if (tripPriceEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterTripPrice,
        error: true,
      );
      return false;
    } else if (num.parse(tripPriceEditingController.text) == 0) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.tripPriceCantBeZero,
        error: true,
      );
      return false;
    } else if (tripMinPaymentEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterMinPayment,
        error: true,
      );
      return false;
    } else if (num.parse(tripMinPaymentEditingController.text) >
        num.parse(tripPriceEditingController.text)) {
      showSnackBar(
        context,
        message:
            AppLocalizations.of(context)!.minPaymentCantBeMoreThanTripPrice,
        error: true,
      );
      return false;
    } else if (numberOfPeopleEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterNoOfPeople,
        error: true,
      );
      return false;
    } else if (tripDescriptionEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterTripDescription,
        error: true,
      );
      return false;
    } else if (time_ == 'Choose Time') {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.chooseTripTime,
        error: true,
      );
      return false;
    } else if (date_ == 'Choose Date') {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.chooseTripDate,
        error: true,
      );
      return false;
    } else if (oldTripImages.isEmpty && newTripImages!.isEmpty) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.chooseTripImages,
        error: true,
      );
      return false;
    }
    return true;
  }

  Trip get trip {
    Trip trip = Trip(
      tripId: widget.tripId,
      name: tripNameEditingController.text.toString(),
      price: tripPriceEditingController.text.toString(),
      minPayment: tripMinPaymentEditingController.text.toString(),
      description: tripDescriptionEditingController.text.toString(),
      time: time_,
      date: date_,
      addressCityId: widget.tripCityId,
      addressCityName: widget.tripAddress,
      addressCityNameAr: widget.tripAddressAr,
      images: oldTripImages,
      officeEmail: SharedPrefController().getEmail,
      officeName: SharedPrefController().getFullName,
      officeId: SharedPrefController().getUId,
      number: numberOfPeopleEditingController.text.toString(),
      space: widget.space,
    );
    return trip;
  }

  String createNotificationId() {
    String dateTimeNow =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}-${DateTime.now().hour}-${DateTime.now().minute}-${DateTime.now().second}-${DateTime.now().millisecond}';
    return 'EditTripNotification:$dateTimeNow-${SharedPrefController().getUId}';
  }

  Future<void> editTrip() async {
    setState(() {
      loading = true;
    });

    String messageTitle = 'تعديل على رحلة';
    String changesMade = 'تم التعديل على الرحلة: ';
    String changesMadeBy = ' من قبل المكتب: ';
    String messageBody = changesMade +
        oldTripName +
        changesMadeBy +
        SharedPrefController().getFullName;
    await FbFireStoreTripsController().editTrip(trip: trip);
    await FbFireStoreNotificationsController().addNotificationToUsers(
      tripId: widget.tripId,
      notification: NotificationModel(
        notificationId: createNotificationId(),
        title: messageTitle,
        body: messageBody,
        reason: '',
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
    if (newTripImages!.isNotEmpty) {
      for (int i = 0; i < newTripImages!.length; i++) {
        await uploadImages(newTripImages![i].path);
      }
    } else {
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  Future<void> uploadImages(String path) async {
    await FbStorageController().uploadTripImages(
      file: File(path),
      context: context,
      tripId: widget.tripId,
      callBackUrl: ({
        required String url,
        required bool status,
        required TaskState taskState,
      }) async {
        if (taskState == TaskState.success) {
          await officeTripsCollectionReference
              .doc(trip.tripId)
              .update({
                'images': FieldValue.arrayUnion([
                  url,
                ]),
              })
              .then((value) {})
              .catchError((onError) {});

          await FirebaseFirestore.instance
              .collection('cities')
              .doc(trip.addressCityName)
              .collection('trips')
              .doc(trip.tripId)
              .update({
                'images': FieldValue.arrayUnion([
                  url,
                ]),
              })
              .then((value) {})
              .catchError((onError) {});
          imagesUploaded++;
          if (imagesUploaded == newTripImages!.length) {
            setState(() {
              loading = false;
            });
            Navigator.pop(context);
            Navigator.pop(context);
          }
        }
      },
    );
  }

  Future<void> deleteOldImage({
    required int index,
    required String url,
  }) async {
    await FbFireStoreTripsController().deleteTripImage(
      tripId: widget.tripId,
      tripCity: widget.tripAddress,
      imageUrl: url,
    );
    setState(() {
      oldTripImages.removeAt(index);
    });
  }

  showDeleteImageAlertDialog(
    BuildContext context, {
    required int index,
    required String url,
  }) {
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
        await deleteOldImage(
          index: index,
          url: url,
        );
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(AppLocalizations.of(context)!.deleteImage),
      content: Text(AppLocalizations.of(context)!.sureDeleteImage),
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

  Future<void> pickImage() async {
    List<XFile>? pickedImages = await imagePicker.pickMultiImage();
    if (pickedImages!.isNotEmpty) {
      newTripImages!.addAll(pickedImages);
    }
    setState(() {});
  }
}
