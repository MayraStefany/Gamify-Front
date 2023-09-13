import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_sliver_app_bar.dart';
import 'package:gamify_app/screens/event_summary/components/event_summary_page.dart';
import 'package:gamify_app/utils/constans.dart';

class EventSummaryScreen extends StatefulWidget {
  const EventSummaryScreen({super.key});

  @override
  State<EventSummaryScreen> createState() => _EventSummaryScreenState();
}

class _EventSummaryScreenState extends State<EventSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            CustomSliverAppBar(
              graphicDisabled: true,
            ),
            SliverFillRemaining(
              child: EventSummaryPage(),
            )
          ],
        ),
      ),
    );
  }
}
