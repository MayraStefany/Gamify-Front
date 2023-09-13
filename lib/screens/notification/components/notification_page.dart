import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamify_app/screens/notification/components/notification_item.dart';
import 'package:gamify_app/services/notification_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/models/notification.dart' as n;
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => NotificationPageState();
}

class NotificationPageState extends State<NotificationPage> {
  final notificationService = NotificationService.instance;
  List<n.Notification>? notifications = [];
  bool isShowSpinner = false;
  AppState? appState;

  @override
  void initState() {
    super.initState();
    setData();
    appState = Provider.of<AppState>(context, listen: false);
    appState!.addListener(setData);
  }

  Future<void> setData() async {
    setState(() => isShowSpinner = true);
    notifications!.clear();
    notifications = await notificationService.getNotifications();
    setState(() => isShowSpinner = false);
  }

  @override
  void dispose() {
    super.dispose();
    appState!.removeListener(setData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                kNotificationMenuImagePath,
                width: 40,
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                'NOTIFICACIONES',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w400,
                  fontFamily: kBungeeFont,
                  color: kGrayColor,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        isShowSpinner
            ? SpinKitCircle(
                size: kSizeLoading,
                itemBuilder: (BuildContext context, int index) {
                  return const DecoratedBox(
                    decoration: BoxDecoration(
                      color: kGrayColor,
                    ),
                  );
                },
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  children: notifications!
                      .map((notification) => NotificationItem(
                            notification: notification,
                          ))
                      .toList(),
                ),
              )
      ],
    );
  }
}
