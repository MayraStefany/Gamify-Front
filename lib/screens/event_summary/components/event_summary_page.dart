import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamify_app/models/event_summary.dart';
import 'package:gamify_app/screens/event_summary/components/area_chart.dart';
import 'package:gamify_app/screens/event_summary/components/circular_chart.dart';
import 'package:gamify_app/services/event_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/utils/utils.dart';
import 'package:provider/provider.dart';

class EventSummaryPage extends StatefulWidget {
  const EventSummaryPage({super.key});

  @override
  State<EventSummaryPage> createState() => EventSummaryPageState();
}

class EventSummaryPageState extends State<EventSummaryPage> {
  final eventService = EventService.instance;
  EventSummary? eventSummary;
  bool isShowSpinner = false;

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    setState(() => isShowSpinner = true);
    final user = Provider.of<AppState>(context, listen: false).user;
    eventSummary = await eventService.getEventSummary(userId: user!.userId);
    setState(() => isShowSpinner = false);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  kEventSummaryImagePath,
                  width: 40,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'DETALLE DE TAREAS',
                  style: TextStyle(
                    fontSize: 25,
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
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      AreaChart(
                        datesDetail: eventSummary!.datesDetail,
                      ),
                      CircularChart(
                        eventSummary: eventSummary!,
                      ),
                      CardSummary(
                          percentage:
                              double.parse('${eventSummary?.advance ?? 0}')),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}

class CardSummary extends StatelessWidget {
  final double percentage;
  const CardSummary({
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    Color getColor() {
      EvaluationSummary evaluationSummary =
          Utils.getEvaluationSummary(percentage);
      return (evaluationSummary == EvaluationSummary.veryDeficient)
          ? kPrimaryColor
          : (evaluationSummary == EvaluationSummary.deficient)
              ? kActiveColor
              : kGreenColor;
    }

    getText() {
      EvaluationSummary evaluationSummary =
          Utils.getEvaluationSummary(percentage);
      return (evaluationSummary == EvaluationSummary.veryDeficient)
          ? 'Muy Deficiente'
          : (evaluationSummary == EvaluationSummary.deficient)
              ? 'Deficiente'
              : 'Execelente';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          border: Border.all(
            color: getColor(),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.bar_chart,
                    size: 30,
                    color: getColor(),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Avance: ${getText()}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontFamily: kRulukoFont,
                      color: kGrayColor,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Hasta el momento has cumplido con el ${percentage.toStringAsFixed(2)}% de tus tareas registradas.',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  fontFamily: kRulukoFont,
                  color: kGrayColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
