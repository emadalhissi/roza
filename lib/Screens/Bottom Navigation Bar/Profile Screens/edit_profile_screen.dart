import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Rehlati/FireBase/fb_storage_controller.dart';
import 'package:Rehlati/Providers/profile_provider.dart';
import 'package:Rehlati/helpers/snack_bar.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:Rehlati/widgets/app_text_field.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen>
    with SnackBarHelper {
  CollectionReference usersCollectionReference =
      FirebaseFirestore.instance.collection('users');
  CollectionReference officesCollectionReference =
      FirebaseFirestore.instance.collection('offices');

  late TextEditingController nameEditingController;
  late TextEditingController mobileEditingController;

  bool loading = false;
  var imagePicker = ImagePicker();
  File? file_;
  XFile? xFile_;

  @override
  void initState() {
    super.initState();
    nameEditingController =
        TextEditingController(text: SharedPrefController().getFullName);
    mobileEditingController =
        TextEditingController(text: SharedPrefController().getMobile);
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    mobileEditingController.dispose();
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
        title: Text(
          AppLocalizations.of(context)!.editProfile,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 100),
                InkWell(
                  onTap: () {},
                  child: SizedBox(
                    width: 110,
                    height: 110,
                    child: Stack(
                      children: [
                        profileImage(),
                        PositionedDirectional(
                          end: 0,
                          bottom: 0,
                          child: InkWell(
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                AppTextField(
                  textEditingController: nameEditingController,
                  hint: AppLocalizations.of(context)!.fullName,
                ),
                const SizedBox(height: 10),
                AppTextField(
                  textEditingController: mobileEditingController,
                  hint: AppLocalizations.of(context)!.mobileNumber,
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  child: loading
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : Text(
                          AppLocalizations.of(context)!.edit,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                          ),
                        ),
                  onPressed: () async {
                    await preformEditProfile();
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
      ),
    );
  }

  Future<void> pickImage() async {
    var pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    File file = File(pickedImage!.path);
    setState(() {
      file_ = file;
    });
  }

  Future<void> preformEditProfile() async {
    if (checkData()) {
      await edit();
    }
  }

  bool checkData() {
    if (nameEditingController.text.isEmpty) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.enterFullName,
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
    } else if (mobileEditingController.text.length != 10) {
      showSnackBar(
        context,
        message: AppLocalizations.of(context)!.mobileMustBe10Digits,
        error: true,
      );
      return false;
    }
    return true;
  }

  Future<void> uploadImage() async {
    setState(() {
      loading = true;
    });
    await FbStorageController().uploadProfileImage(
      file: file_!,
      context: context,
      callBackUrl: ({
        required String url,
        required bool status,
        required TaskState taskState,
      }) async {
        if (SharedPrefController().getAccountType == 'user') {
          await usersCollectionReference
              .doc(SharedPrefController().getUId)
              .update(
            {
              'profileImage': url,
            },
          );
          Provider.of<ProfileProvider>(context, listen: false)
              .setProfileImage_(url);

          setState(() {});
          Navigator.pop(context, () {
            setState(() {});
          });
        } else {
          await officesCollectionReference
              .doc(SharedPrefController().getUId)
              .update(
            {
              'profileImage': url,
            },
          );
          Provider.of<ProfileProvider>(context, listen: false)
              .setProfileImage_(url);
          setState(() {});
          Navigator.pop(context, () {
            setState(() {});
          });
        }
      },
    );
  }

  Future<void> edit() async {
    if (SharedPrefController().getAccountType == 'user') {
      await usersCollectionReference.doc(SharedPrefController().getUId).update({
        'name': nameEditingController.text.toString(),
        'mobile': mobileEditingController.text.toString(),
      }).then((value) {
        Provider.of<ProfileProvider>(context, listen: false)
            .setName_(nameEditingController.text.toString());
        Provider.of<ProfileProvider>(context, listen: false)
            .setMobile_(mobileEditingController.text.toString());
        if (file_ != null) {
          setState(() {});
          uploadImage();
        } else {
          Navigator.pop(context);
        }
      }).catchError((onError) {});
    } else {
      await officesCollectionReference
          .doc(SharedPrefController().getUId)
          .update({
        'name': nameEditingController.text.toString(),
        'mobile': mobileEditingController.text.toString(),
      }).then((value) {
        Provider.of<ProfileProvider>(context, listen: false)
            .setName_(nameEditingController.text.toString());
        Provider.of<ProfileProvider>(context, listen: false)
            .setMobile_(mobileEditingController.text.toString());
        if (file_ != null) {
          uploadImage();
        } else {
          Navigator.pop(context);
        }
      }).catchError((onError) {});
    }
  }

  Widget profileImage() {
    if (Provider.of<ProfileProvider>(context).profileImage_ == '' &&
        file_ == null) {
      return const CircleAvatar(
        radius: 55,
        backgroundColor: Color(0xff5859F3),
      );
    } else if (Provider.of<ProfileProvider>(context).profileImage_ == '' &&
        file_ != null) {
      return CircleAvatar(
        radius: 55,
        backgroundColor: Colors.transparent,
        backgroundImage: FileImage(File(file_!.path)),
      );
    } else if (Provider.of<ProfileProvider>(context).profileImage_.isNotEmpty &&
        file_ == null) {
      return CircleAvatar(
        radius: 55,
        backgroundColor: Colors.transparent,
        backgroundImage: CachedNetworkImageProvider(
            Provider.of<ProfileProvider>(context).profileImage_),
      );
    } else if (Provider.of<ProfileProvider>(context).profileImage_.isNotEmpty &&
        file_ != null) {
      return CircleAvatar(
        radius: 55,
        backgroundColor: Colors.transparent,
        backgroundImage: FileImage(File(file_!.path)),
      );
    }
    return const SizedBox.shrink();
  }
}
