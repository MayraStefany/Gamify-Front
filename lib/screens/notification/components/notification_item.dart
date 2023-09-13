import 'package:flutter/material.dart';
import 'package:gamify_app/models/notification.dart' as n;
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';

class NotificationItem extends StatelessWidget {
  final n.Notification notification;
  const NotificationItem({
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            width: 2,
            color: Color(0xFF676565),
          ),
          color: Colors.black,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    kNotificationImagePath,
                    width: 50,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    notification.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: kRulukoFont,
                      color: kGrayColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                notification.message,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  fontFamily: kRulukoFont,
                  color: kGrayColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
