import 'dart:io';

import 'package:Rehlati/models/trip.dart';
import 'package:Rehlati/preferences/shared_preferences_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

typedef CallBackUrl = void Function({
  required String url,
  required bool status,
  required TaskState taskState,
});

class FbStorageController {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<void> uploadProfileImage({
    required File file,
    required BuildContext context,
    required CallBackUrl callBackUrl,
  }) async {
    UploadTask uploadTask = _firebaseStorage
        .ref(
            'Profile Images/${SharedPrefController().getAccountType}/${SharedPrefController().getUId}/' +
                DateTime.now().toString() +
                'image')
        .putFile(file);
    uploadTask.snapshotEvents.listen((event) async {
      if (event.state == TaskState.running) {
      } else if (event.state == TaskState.success) {
        Reference imageReference = event.ref;
        var url = await imageReference.getDownloadURL();
        callBackUrl(
          url: url,
          status: true,
          taskState: event.state,
        );
      } else if (event.state == TaskState.error) {}
    });
  }

  Future<void> uploadTripImages({
    required File file,
    required BuildContext context,
    required CallBackUrl callBackUrl,
    required String tripId,
  }) async {
    UploadTask uploadTask = _firebaseStorage
        .ref('Trips Images/${SharedPrefController().getEmail}/$tripId/' +
            DateTime.now().toString() +
            'image')
        .putFile(file);
    uploadTask.snapshotEvents.listen((event) async {
      if (event.state == TaskState.running) {
      } else if (event.state == TaskState.success) {
        Reference imageReference = event.ref;
        var url = await imageReference.getDownloadURL();
        callBackUrl(
          url: url,
          status: true,
          taskState: event.state,
        );
      } else if (event.state == TaskState.error) {}
    });
  }
}
