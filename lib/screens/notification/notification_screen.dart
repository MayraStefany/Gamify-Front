import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_sliver_app_bar.dart';
import 'package:gamify_app/screens/notification/components/notification_page.dart';
import 'package:gamify_app/utils/constans.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  GlobalKey<NotificationPageState> notificationPage = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: kBackgroundColor,
          backgroundColor: kGrayColor,
          displacement: 30,
          strokeWidth: 2,
          onRefresh: () async {
            await notificationPage.currentState!.setData();
          },
          child: CustomScrollView(
            slivers: [
              CustomSliverAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    NotificationPage(
                      key: notificationPage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
