import 'package:Rehlati/models/FireBase%20Message/message_data_request.dart';
import 'package:Rehlati/models/FireBase%20Message/message_notification_request.dart';

class MessageBaseRequest {
  late List<String>? registrationIds;
  late MessageNotificationRequest? notification;
  late MessageDataRequest? data;

  MessageBaseRequest({
    required this.registrationIds,
    required this.notification,
    required this.data,
  });

  MessageBaseRequest.fromJson(Map<String, dynamic> json) {
    registrationIds = json['registration_ids'].cast<String>();
    notification = json['notification'] != null
        ? MessageNotificationRequest.fromJson(json['notification'])
        : null;
    data =
        json['data'] != null ? MessageDataRequest.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['registration_ids'] = registrationIds;
    if (notification != null) {
      data['notification'] = notification!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
