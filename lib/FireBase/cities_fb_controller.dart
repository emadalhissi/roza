import 'package:cloud_firestore/cloud_firestore.dart';

class CitiesFbController {
  final FirebaseFirestore _firebaseFireStoreUsers = FirebaseFirestore.instance;

  Stream<QuerySnapshot> readCities() async* {
    yield* _firebaseFireStoreUsers.collection('cities').snapshots();
  }
}
