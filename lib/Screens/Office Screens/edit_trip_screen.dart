import 'dart:io';
import 'package:Rehlati/FireBase/fb_firestore_trips_controller.dart';
import 'package:Rehlati/FireBase/fb_storage_controller.dart';
import 'package:Rehlati/Providers/cities_provider.dart';
import 'package:Rehlati/helpers/snack_bar.dart';
import 'package:Rehlati/models/city.dart';
import 'package:Rehlati/models/trip.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:Rehlati/widgets/app_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    tripNameEditingController = TextEditingController(text: widget.tripName);
    tripDescriptionEditingController =
        TextEditingController(text: widget.tripDescription);
    tripPriceEditingController = TextEditingController(text: widget.price);
    tripMinPaymentEditingController =
        TextEditingController(text: widget.minPayment);
  }

  @override
  void dispose() {
    tripNameEditingController.dispose();
    tripDescriptionEditingController.dispose();
    tripPriceEditingController.dispose();
    tripMinPaymentEditingController.dispose();
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
              const Text(
                'Trip Details',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              AppTextField(
                textEditingController: tripNameEditingController,
                hint: 'Trip Name',
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: tripPriceEditingController,
                hint: 'Trip Price',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: tripMinPaymentEditingController,
                hint: 'Min Payment',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              AppTextField(
                textEditingController: tripDescriptionEditingController,
                hint: 'Description',
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
                  const Text(
                    'Trip Images',
                    style: TextStyle(
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
                                      File(newTripImages![index].path)),
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
                    : const Text(
                        'Edit Trip',
                        style: TextStyle(
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
                  children: const [
                    Icon(
                      Icons.camera_alt,
                      color: Colors.grey,
                      size: 50,
                    ),
                    Text(
                      'Add Image',
                      style: TextStyle(
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
        message: 'Enter Trip Name!',
        error: true,
      );
      return false;
    } else if (tripPriceEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: 'Enter Trip Price!',
        error: true,
      );
      return false;
    } else if (num.parse(tripPriceEditingController.text) == 0) {
      showSnackBar(
        context,
        message: 'Trip Price Can\'t be zero!',
        error: true,
      );
      return false;
    } else if (tripMinPaymentEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: 'Enter Min Payment!',
        error: true,
      );
      return false;
    } else if (num.parse(tripMinPaymentEditingController.text) >
        num.parse(tripPriceEditingController.text)) {
      showSnackBar(
        context,
        message: 'Min Payment Can\'t be more than trip price!',
        error: true,
      );
      return false;
    } else if (tripDescriptionEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: 'Enter Trip Description!',
        error: true,
      );
      return false;
    } else if (time_ == 'Choose Time') {
      showSnackBar(
        context,
        message: 'Choose Trip Time!',
        error: true,
      );
      return false;
    } else if (date_ == 'Choose Date') {
      showSnackBar(
        context,
        message: 'Choose Trip Date!',
        error: true,
      );
      return false;
    } else if (oldTripImages.isEmpty && newTripImages!.isEmpty) {
      showSnackBar(
        context,
        message: 'Choose Trip Images!',
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
    );
    return trip;
  }

  Future<void> editTrip() async {
    setState(() {
      loading = true;
    });
    await FbFireStoreTripsController().editTrip(trip: trip);
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
      child: const Text(
        'No',
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () {
        Navigator.pop(context, () {
          setState(() {});
        });
      },
    );
    Widget continueButton = TextButton(
      child: const Text(
        'Yes',
        style: TextStyle(color: Colors.black),
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
      title: const Text('Delete Image!'),
      content: const Text('Are you sure you want to delete this image?'),
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
    // var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    List<XFile>? pickedImages = await imagePicker.pickMultiImage();
    if (pickedImages!.isNotEmpty) {
      newTripImages!.addAll(pickedImages);
    }
    setState(() {});
  }
}
