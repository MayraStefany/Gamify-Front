import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_sliver_app_bar.dart';
import 'package:gamify_app/components/user_points.dart';
import 'package:gamify_app/screens/survey/components/survey_page.dart';
import 'package:gamify_app/utils/constans.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen();

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  GlobalKey<SurveyPageState> surveyPage = GlobalKey();

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
            await surveyPage.currentState!.setData();
          },
          child: CustomScrollView(
            slivers: [
              CustomSliverAppBar(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    UserPoints(),
                    SurveyPage(key: surveyPage),
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
