import 'package:Rehlati/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FbFireStoreUsersController {
  final FirebaseFirestore _firebaseFireStoreUsers = FirebaseFirestore.instance;

  // CRUD

  Future<bool> createUser({
    required UserModel user,
  }) async {
    return _firebaseFireStoreUsers
        .collection('users')
        .doc(user.uId)
        .set(user.toMap())
        .then((value) => true)
        .catchError((error) => false);
  }
}
