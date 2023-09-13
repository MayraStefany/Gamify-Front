import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamify_app/models/summary_survey.dart';
import 'package:gamify_app/services/survey_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/utils/utils.dart';
import 'package:provider/provider.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final surveyService = SurveyService.instance;
  bool isShowSpinner = false;
  SummarySurvey? summarySurvey;

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    setState(() => isShowSpinner = true);
    final user = Provider.of<AppState>(context, listen: false).user;
    summarySurvey = await surveyService.getSummarySurvey(userId: user!.userId);
    setState(() => isShowSpinner = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: kGrayColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              kMyTimeAndTasksHeaderImagePath,
                              width: 50,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Column(
                              children: [
                                Text(
                                  'MI TIEMPO Y',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: kBungeeFont,
                                    color: kGrayColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'TAREAS',
                                  style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: kBungeeFont,
                                    color: kGrayColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
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
                            vertical: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '1. Total de actividades completadas:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: kRulukoFont,
                                  color: kGrayColor,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                ),
                                child: SummaryInfo(
                                  text: '${summarySurvey!.eventsDone}',
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              LevelOfCompliance(
                                title: '2. Nivel de cumplimiento de tareas',
                                valueBefore: summarySurvey!
                                    .taskCompletion.before
                                    .toStringAsFixed(2),
                                valueAfter: summarySurvey!.taskCompletion.after
                                    .toStringAsFixed(2),
                                percentage: double.parse(
                                        '${summarySurvey!.taskCompletion.after}') /
                                    double.parse(
                                        '${summarySurvey!.taskCompletion.before}') *
                                    100,
                                summarySurveyType:
                                    SummarySurveyType.taskCompletion,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              LevelOfCompliance(
                                title:
                                    '3. Habilidades para gestionar tu tiempo',
                                valueBefore: summarySurvey!
                                    .timeManagement.before
                                    .toStringAsFixed(2),
                                valueAfter: summarySurvey!.timeManagement.after
                                    .toStringAsFixed(2),
                                percentage: double.parse(
                                        '${summarySurvey!.timeManagement.after}') /
                                    double.parse(
                                        '${summarySurvey!.timeManagement.before}') *
                                    100,
                                summarySurveyType:
                                    SummarySurveyType.timeManagement,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              LevelOfCompliance(
                                title: '4. Nivel de Participación',
                                valueBefore: summarySurvey!.participation.before
                                    .toStringAsFixed(2),
                                valueAfter: summarySurvey!.participation.after
                                    .toStringAsFixed(2),
                                percentage: double.parse(
                                        '${summarySurvey!.participation.after}') /
                                    double.parse(
                                        '${summarySurvey!.participation.before}') *
                                    100,
                                summarySurveyType:
                                    SummarySurveyType.participation,
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LevelOfCompliance extends StatefulWidget {
  final String title;
  final String valueBefore;
  final String valueAfter;
  final double percentage;
  final SummarySurveyType summarySurveyType;
  const LevelOfCompliance({
    required this.title,
    required this.valueBefore,
    required this.valueAfter,
    required this.percentage,
    required this.summarySurveyType,
  });

  @override
  State<LevelOfCompliance> createState() => _LevelOfComplianceState();
}

class _LevelOfComplianceState extends State<LevelOfCompliance> {
  late String resultText;
  late Color color;
  String? image;

  @override
  void initState() {
    super.initState();
    EvaluationSummary evaluationSummary =
        Utils.getEvaluationSummary(widget.percentage);
    setResultText(
        widget.percentage, widget.summarySurveyType, evaluationSummary);
    setImage(widget.percentage, evaluationSummary);
    setColor(widget.percentage, evaluationSummary);
    setState(() {});
  }

  setResultText(double percentage, SummarySurveyType summarySurveyType,
      EvaluationSummary evaluationSummary) {
    if (summarySurveyType == SummarySurveyType.taskCompletion) {
      resultText = (evaluationSummary == EvaluationSummary.veryDeficient)
          ? 'Disminuyo su nivel de cumplimiento'
          : (evaluationSummary == EvaluationSummary.deficient)
              ? 'Sostuvo su nivel de cumplimiento'
              : 'Mejoro su nivel de cumplimiento';
    } else if (summarySurveyType == SummarySurveyType.timeManagement) {
      resultText = (evaluationSummary == EvaluationSummary.veryDeficient)
          ? 'Disminuyo su nivel de gestión'
          : (evaluationSummary == EvaluationSummary.deficient)
              ? 'Sostuvo su nivel de gestión'
              : 'Mejoro su nivel de gestión';
    } else {
      resultText = (evaluationSummary == EvaluationSummary.veryDeficient)
          ? 'Disminuyo su nivel de participación'
          : (evaluationSummary == EvaluationSummary.deficient)
              ? 'Sostuvo su nivel de participación'
              : 'Mantuvo su nivel de participación';
    }
  }

  setImage(double percentage, EvaluationSummary evaluationSummary) {
    image = (evaluationSummary == EvaluationSummary.veryDeficient)
        ? kSummaryVeryDeficientImagePath
        : (evaluationSummary == EvaluationSummary.deficient)
            ? kDeficientSummaryImagePath
            : kExcellentSummaryImagePath;
  }

  setColor(double percentage, EvaluationSummary evaluationSummary) {
    color = (evaluationSummary == EvaluationSummary.veryDeficient)
        ? Color(0xFFD99A70)
        : (evaluationSummary == EvaluationSummary.deficient)
            ? Color(0xFFF9CC7A)
            : Color(0xFFA9DF9C);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: kRulukoFont,
            color: kGrayColor,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 70,
                      child: Text(
                        'Antes',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: kRulukoFont,
                          color: kGrayColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SummaryInfo(
                      text: widget.valueBefore,
                      width: 70,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 70,
                      child: Text(
                        'Después',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: kRulukoFont,
                          color: kGrayColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SummaryInfo(
                      text: widget.valueAfter,
                      width: 70,
                    ),
                  ],
                )
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  if (image != null) ...[
                    Image.asset(
                      image!,
                      height: 60,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                  Text(
                    resultText,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      fontFamily: kRulukoFont,
                      color: color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class SummaryInfo extends StatelessWidget {
  final double? width;
  final String text;
  const SummaryInfo({
    this.width,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: width,
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
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: kGrayColor,
          ),
        ),
      ),
    );
  }
}
