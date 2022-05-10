import 'package:Rehlati/models/office.dart';
import 'package:Rehlati/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FbFireStoreOfficesController {
  final FirebaseFirestore _firebaseFireStoreUsers = FirebaseFirestore.instance;

  // CRUD

  Future<bool> createOffice({
    required OfficeModel office,
  }) async {
    return _firebaseFireStoreUsers
        .collection('offices')
        .doc(office.uId)
        .set(office.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
}
