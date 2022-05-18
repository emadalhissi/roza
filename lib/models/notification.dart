import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  late String notificationId;
  late String title;
  late String body;
  late String reason;
  late Timestamp timestamp;

  NotificationModel({
    required this.notificationId,
    required this.title,
    required this.body,
    required this.reason,
    required this.timestamp,
  });

  NotificationModel.fromMap(Map<String, dynamic> documentMap) {
    notificationId = documentMap['notificationId'];
    title = documentMap['title'];
    body = documentMap['body'];
    reason = documentMap['reason'];
    timestamp = documentMap['timestamp'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['notificationId'] = notificationId;
    map['title'] = title;
    map['body'] = body;
    map['reason'] = reason;
    map['timestamp'] = timestamp;
    return map;
  }
}
