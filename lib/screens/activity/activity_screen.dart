import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/components/custom_sliver_app_bar.dart';
import 'package:gamify_app/screens/activity/components/calendar_page.dart';
import 'package:gamify_app/screens/activity/new_activity_screen.dart';
import 'package:gamify_app/utils/constans.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  GlobalKey<CalendarPageState> calendarPage = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      floatingActionButton: CustomButton(
        height: 35,
        width: 50,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewActivityScreen(
                onRefresh: () {
                  calendarPage.currentState!.setData();
                },
              ),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          size: 35,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(),
            SliverFillRemaining(
              child: CalendarPage(
                key: calendarPage,
              ),
            )
          ],
        ),
      ),
    );
  }
}
