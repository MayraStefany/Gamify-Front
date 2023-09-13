import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/models/week.dart';
import 'package:gamify_app/screens/survey/components/survey_item.dart';
import 'package:gamify_app/screens/survey/summary_screen.dart';
import 'package:gamify_app/services/survey_service.dart';
import 'package:gamify_app/services/week_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:provider/provider.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({super.key});

  @override
  State<SurveyPage> createState() => SurveyPageState();
}

class SurveyPageState extends State<SurveyPage> {
  final weekService = WeekService.instance;
  final surveyService = SurveyService.instance;
  List<Week>? weeks = [];
  bool isShowSpinner = false;
  bool showSummary = false;
  String? weekSurvey;
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
    weeks!.clear();
    weekSurvey = null;
    showSummary = false;
    final user = Provider.of<AppState>(context, listen: false).user;
    final weekId = Provider.of<AppState>(context, listen: false).weekId;
    weeks = await weekService.getWeeks();
    final surveysDone =
        await surveyService.getSurveysDoneByUserId(userId: user!.userId);
    final index = weeks!.indexWhere((week) => week.id == weekId);
    for (int i = 0; i <= index; i++) {
      weeks?[i].painted = true;
    }
    if (surveysDone.where((survey) => survey.weekId == weekId).isEmpty) {
      weekSurvey = weekId;
    }
    if (weekId == weeks?.last.id && weekSurvey == null) {
      showSummary = true;
    }
    setState(() => isShowSpinner = false);
  }

  @override
  void dispose() {
    super.dispose();
    appState!.removeListener(setData);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: isShowSpinner
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
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Container(
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: Color(0xFF863F48),
                        width: 1.5,
                      ),
                      color: kButtonColor,
                    ),
                    child: const Center(
                      child: Text(
                        'ENCUESTA',
                        style: TextStyle(
                          color: kGrayColor,
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          fontFamily: kGugiFont,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: weeks!
                      .map(
                        (week) => SurveyItem(
                          week: week,
                          onRefresh: () => setData(),
                          canTakeSurvey: week.id == weekSurvey,
                        ),
                      )
                      .toList(),
                ),
                if (showSummary) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: CustomButton(
                      height: 45,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SummaryScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Ver mi resumen',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontFamily: kGugiFont,
                        ),
                      ),
                    ),
                  ),
                ]
              ],
            ),
    );
  }
}
