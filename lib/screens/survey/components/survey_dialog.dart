import 'package:flutter/material.dart';
import 'package:gamify_app/components/custom_button.dart';
import 'package:gamify_app/components/survey_item.dart';
import 'package:gamify_app/models/survey.dart';
import 'package:gamify_app/models/week.dart';
import 'package:gamify_app/services/survey_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'package:gamify_app/utils/utils.dart';
import 'package:provider/provider.dart';

class SurveyDialog extends StatefulWidget {
  final Week week;
  final Function onRefresh;
  final BuildContext dialogContext;
  const SurveyDialog({
    required this.week,
    required this.onRefresh,
    required this.dialogContext,
  });

  @override
  State<SurveyDialog> createState() => _SurveyDialogState();
}

class _SurveyDialogState extends State<SurveyDialog> {
  final surveyService = SurveyService.instance;
  Survey? survey;
  bool isShowSpinner = false;

  @override
  void initState() {
    super.initState();
    survey = Survey();
  }

  Future<void> saveSurvey() async {
    try {
      setState(() => isShowSpinner = true);
      final user = Provider.of<AppState>(context, listen: false).user;
      survey?.userId = user?.userId;
      survey?.weekId = widget.week.id;
      await surveyService.createSurvey(
        survey: survey!,
      );
      Navigator.pop(context);
      widget.onRefresh();
      Utils.showCustomDialog(
        context: context,
        text: 'Encuesta realizada con éxito',
      );
    } catch (e) {
      Utils.showCustomDialog(
        context: context,
        text: (e is ServiceException) ? e.message : kMensajeErrorGenerico,
        isError: true,
      );
    } finally {
      setState(() => isShowSpinner = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 10,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      kApplauseImagePath,
                      height: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '¡TERMINAMOS LA SEMANA ${widget.week.number}!',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: kBungeeFont,
                        color: kGrayColor,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      SurveyItem(
                        text:
                            '¿Cómo evaluarías tu gestión tu tiempo para esta semana?',
                        fontSizeText: 14,
                        onTap: (int value) {
                          survey?.timeManagement = value;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SurveyItem(
                        text:
                            '¿Cuál fue tu nivel de participación en las clases esta semana?',
                        fontSizeText: 14,
                        onTap: (int value) {
                          survey?.participation = value;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: CustomButton(
                    height: 45,
                    color: Color(0xFF495F75),
                    onTap: () {
                      if (survey?.timeManagement != null &&
                          survey?.participation != null) {
                        saveSurvey();
                      } else {
                        Utils.showMessage(
                          context,
                          'Por favor complete la encuesta',
                        );
                      }
                    },
                    child: const Text(
                      'Enviar',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontFamily: kGugiFont,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: GestureDetector(
            onTap: () {
              Navigator.pop(widget.dialogContext);
            },
            child: const Icon(
              Icons.close,
              color: kGrayColor,
            ),
          ),
        ),
        if (isShowSpinner)
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              color: Colors.black.withOpacity(0.6),
              width: double.infinity,
              height: double.infinity,
              child: const Center(
                child: CircularProgressIndicator(
                  color: kGrayColor,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
