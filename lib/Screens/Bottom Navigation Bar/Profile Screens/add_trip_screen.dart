import 'dart:io';
import 'dart:math';

import 'package:Rehlati/FireBase/cities_fb_controller.dart';
import 'package:Rehlati/FireBase/fb_firestore_trips_controller.dart';
import 'package:Rehlati/FireBase/fb_storage_controller.dart';
import 'package:Rehlati/Providers/cities_provider.dart';
import 'package:Rehlati/helpers/snack_bar.dart';
import 'package:Rehlati/models/city.dart';
import 'package:Rehlati/models/image.dart';
import 'package:Rehlati/models/trip.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:Rehlati/widgets/app_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:provider/provider.dart';

class AddTripScreen extends StatefulWidget {
  const AddTripScreen({Key? key}) : super(key: key);

  @override
  _AddTripScreenState createState() => _AddTripScreenState();
}

class _AddTripScreenState extends State<AddTripScreen> with SnackBarHelper {
  late TextEditingController tripNameEditingController;
  late TextEditingController tripDescriptionEditingController;
  late TextEditingController tripPriceEditingController;
  late TextEditingController tripMinPaymentEditingController;

  var random = Random().nextInt(1000000);

  var imagePicker = ImagePicker();
  File? file_;

  CollectionReference officesCollectionReference =
      FirebaseFirestore.instance.collection('offices');

  CollectionReference citiesCollectionReference =
      FirebaseFirestore.instance.collection('cities');

  CollectionReference officeTripsCollectionReference = FirebaseFirestore
      .instance
      .collection('offices')
      .doc(SharedPrefController().getUId)
      .collection('trips');

  List<XFile>? tripImages = [];
  int imagesUploaded = 0;

  bool loading = false;

  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();

  String time_ = 'Choose Time';
  String date_ = 'Choose Date';

  City? dropDownCityValue;

  @override
  void initState() {
    super.initState();
    tripNameEditingController = TextEditingController();
    tripDescriptionEditingController = TextEditingController();
    tripPriceEditingController = TextEditingController();
    tripMinPaymentEditingController = TextEditingController();
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
          'Add Trip',
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
              const SizedBox(height: 10),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                ),
                child: DropdownButton<City>(
                  isExpanded: true,
                  itemHeight: 60,
                  underline: const SizedBox.shrink(),
                  value: dropDownCityValue ??
                      Provider.of<CitiesProvider>(context).citiesList[0],
                  items: Provider.of<CitiesProvider>(context)
                      .citiesList
                      .map(
                        (city) => DropdownMenuItem(
                          value: city,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            child: Text(
                              city.name,
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (City? newValue) {
                    setState(() {
                      dropDownCityValue = newValue!;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Trip City Can\'t Be Changed.',
                    style: TextStyle(
                      fontSize: 11,
                      fontStyle: FontStyle.italic,
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
                  tripImages!.isNotEmpty
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
              tripImages!.isEmpty
                  ? InkWell(
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
                    )
                  : GridView.builder(
                      itemBuilder: (context, index) {
                        return Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: FileImage(File(tripImages![index].path)),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Stack(
                            children: [
                              PositionedDirectional(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      tripImages!.removeAt(index);
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
                      itemCount: tripImages!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                    ),
              const SizedBox(height: 30),
              ElevatedButton(
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : const Text(
                        'Add Trip',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                onPressed: () async {
                  await performAddTrip();
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

  Future<void> performAddTrip() async {
    if (checkData()) {
      await addTrip();
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
    } else if (tripImages!.isEmpty) {
      showSnackBar(
        context,
        message: 'Choose Trip Images!',
        error: true,
      );
      return false;
    }
    return true;
  }

  String createTripId() {
    String dateTimeNow =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    return '$random-$dateTimeNow-${SharedPrefController().getUId}';
  }

  Trip get trip {
    Trip trip = Trip(
      tripId: createTripId(),
      name: tripNameEditingController.text.toString(),
      price: tripPriceEditingController.text.toString(),
      minPayment: tripMinPaymentEditingController.text.toString(),
      description: tripDescriptionEditingController.text.toString(),
      time: time_,
      date: date_,
      addressCityId: dropDownCityValue == null
          ? Provider.of<CitiesProvider>(context, listen: false).citiesList[0].id
          : dropDownCityValue!.id,
      addressCityName: dropDownCityValue == null
          ? Provider.of<CitiesProvider>(context, listen: false)
              .citiesList[0]
              .name
          : dropDownCityValue!.name,
      addressCityNameAr: dropDownCityValue == null
          ? Provider.of<CitiesProvider>(context, listen: false)
              .citiesList[0]
              .nameAr
          : dropDownCityValue!.nameAr,
      officeEmail: SharedPrefController().getEmail,
      officeName: SharedPrefController().getFullName,
      officeId: SharedPrefController().getUId,
      images: [],
    );
    return trip;
  }

  Future<void> addTrip() async {
    setState(() {
      loading = true;
    });
    await FbFireStoreTripsController().createTrip(trip: trip);
    for (int i = 0; i < tripImages!.length; i++) {
      await uploadImages(tripImages![i].path);
    }
  }

  Future<void> uploadImages(String path) async {
    await FbStorageController().uploadTripImages(
      file: File(path),
      context: context,
      tripId: createTripId(),
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
          if (imagesUploaded == tripImages!.length) {
            setState(() {
              loading = false;
            });
            Navigator.pop(context);
          }
        }
      },
    );
  }

  Future<void> pickImage() async {
    // var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    List<XFile>? pickedImages = await imagePicker.pickMultiImage();
    if (pickedImages!.isNotEmpty) {
      tripImages!.addAll(pickedImages);
    }
    setState(() {});
  }
}
