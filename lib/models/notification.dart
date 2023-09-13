class Notification {
  String id;
  String title;
  String message;

  Notification({
    required this.id,
    required this.title,
    required this.message,
  });

  Notification.fromMap(Map<String, dynamic> notificationData)
      : id = notificationData['_id'],
        title = notificationData['title'],
        message = notificationData['message'];

  @override
  String toString() =>
      'Notification{id: $id, title: $title, message: $message}';
}
