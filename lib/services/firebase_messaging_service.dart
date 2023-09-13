import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:provider/provider.dart';

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._privateConstructor();
  static FirebaseMessagingService get instance => _instance;
  FirebaseMessagingService._privateConstructor();

  Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<String?> getTokenDispositivo() async {
    final tokenDispositivo = await FirebaseMessaging.instance.getToken();
    return tokenDispositivo;
  }

  void initMessaging(BuildContext context) async {
    await requestPermission();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var androidInitialize = const AndroidInitializationSettings('ic_launcher');
    var initializationsSettings =
        InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onDidReceiveNotificationResponse: (_) {});
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      String? weekId = message.data['weekId'];
      if (weekId != null) {
        await Provider.of<AppState>(context, listen: false).setWeekId(
          weekId: weekId,
        );
      } else {
        await Provider.of<AppState>(context, listen: false)
            .setUpdateNotifications(
          updateNotifications: true,
        );
        BigTextStyleInformation bigTextStyleInformation =
            BigTextStyleInformation(
          '${message.notification?.body ?? ''}',
          htmlFormatContent: true,
          contentTitle: message.notification?.title,
          htmlFormatContentTitle: true,
        );
        AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'gamify',
          'gamify',
          importance: Importance.max,
          styleInformation: bigTextStyleInformation,
          priority: Priority.max,
          enableLights: true,
          playSound: true,
          //sound: const RawResourceAndroidNotificationSound('sonido_notificacion'),
        );
        NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title,
          message.notification?.body,
          platformChannelSpecifics,
          payload: message.data['body'],
        );
      }
    });
  }
}
