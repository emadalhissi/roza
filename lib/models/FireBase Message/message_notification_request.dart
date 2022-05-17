class MessageNotificationRequest {
  late String? title;
  late String? body;

  MessageNotificationRequest({
    this.title,
    this.body,
  });

  MessageNotificationRequest.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    return data;
  }
}
