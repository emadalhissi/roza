import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Rehlati/models/FireBase%20Message/message_base_request.dart';
import 'package:Rehlati/models/FireBase%20Message/message_data_request.dart';
import 'package:Rehlati/models/FireBase%20Message/message_notification_request.dart';
import 'package:Rehlati/models/FireBase%20Message/sent_fire_base_message_from_server_base_response.dart';

class SendFireBaseMessageFromServer {
  Future<void> sentMessage({
    required List<String> fcmTokens,
    required String title,
    required String body,
  }) async {
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var response = await http.post(
      url,
      body: jsonEncode(MessageBaseRequest(
        registrationIds:
            fcmTokens, // FCM Token(s) of the Receiver(s) of the Notification
        notification: MessageNotificationRequest(
          title: title,
          body: body,
        ),
        data: MessageDataRequest(msgId: 'chat_screen'),
      ).toJson()),
      headers: {
        // Authorization: Bearer + FireBase Server Key (FireBase Console > Selected Project > Project Settings > Cloud Messaging)
        'Authorization':
            'Bearer AAAA9v3BRnI:APA91bFBNgLXEeRZvFtO_jovRkRgyi9FbyYKuwqOJDjjHGXh0PvIu82VZwjhUW_P_qPJRU4sb99GyRndgUbF7zJgnNee-UJ7vpjWgSo96mdBRzGJwT4cchYextQCgCCJPUWWL69gqp_f',
        'Accept': '*/*',
        'Content-Type': 'application/json',
        'Connection': 'keep-alive',
      },
    );
    if (response.statusCode == 200) {
      SendFireBaseMessageFromServerBaseResponse.fromJson(
          jsonDecode(response.body));
    } else if (response.statusCode == 401) {}
  }
}
