import 'package:gamify_app/models/notification.dart';
import 'package:gamify_app/services/http_service.dart';
import 'package:gamify_app/utils/http_exception.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'dart:developer' as dev;

class NotificationService {
  final notificationsPath = 'notifications';

  static final NotificationService _instance =
      NotificationService._privateConstructor();
  static NotificationService get instance => _instance;
  NotificationService._privateConstructor();

  final _httpService = HttpService.instance;

  Future<List<Notification>> getNotifications() async {
    try {
      List<dynamic> data = await _httpService.get(
        notificationsPath,
      );
      return data.map((e) => Notification.fromMap(e)).toList();
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'NotificationService.getNotifications');
      throw ServiceException(e.message);
    }
  }
}
