import 'package:flutter/material.dart';
import 'package:gamify_app/models/week.dart';
import 'package:gamify_app/screens/survey/components/survey_dialog.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';

class SurveyItem extends StatelessWidget {
  final Week week;
  final Function onRefresh;
  final bool? canTakeSurvey;
  const SurveyItem({
    required this.week,
    required this.onRefresh,
    this.canTakeSurvey = false,
  });

  @override
  Widget build(BuildContext context) {
    final defaultColor = Color(0xFFC1BBBC);
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: GestureDetector(
        onTap: () {
          if (canTakeSurvey!) {
            showCustomDialog(
              context: context,
              onRefresh: onRefresh,
              week: week,
            );
          }
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            border: Border.all(
              color: week.painted ? kButtonColor : defaultColor,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                  color: week.painted ? kButtonColor : defaultColor,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            kCalendarMenuImagePath,
                            height: 24,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '¡SEMANA ${week.number}!',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              fontFamily: kBungeeFont,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Por favor, completar la encuesta de la semana ${week.number}.',
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showCustomDialog({
    required BuildContext context,
    required Function onRefresh,
    required Week week,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => WillPopScope(
        onWillPop: () => Future.value(false),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(color: Color(0xFFE3DDDD)),
          ),
          backgroundColor: Colors.black,
          actionsPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          content: SurveyDialog(
            week: week,
            onRefresh: onRefresh,
            dialogContext: dialogContext,
          ),
        ),
      ),
    );
  }
}
