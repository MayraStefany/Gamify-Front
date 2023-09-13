import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:gamify_app/models/event_summary.dart';

class CircularChart extends StatefulWidget {
  final EventSummary eventSummary;
  const CircularChart({
    required this.eventSummary,
  });

  @override
  State<CircularChart> createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {
  List<ChartData> chartData = [];

  @override
  void initState() {
    super.initState();
    chartData.add(ChartData(
      text: 'Tareas Completadas',
      count: widget.eventSummary.eventsDone,
      color: Colors.orange,
    ));
    chartData.add(ChartData(
      text: 'Tareas Incumplidas',
      count: widget.eventSummary.eventsNoDone,
      color: Colors.blue,
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: SizedBox(
        height: 200,
        child: SfCircularChart(
          title: ChartTitle(
            text: 'General',
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          legend: Legend(
            isVisible: true,
            alignment: ChartAlignment.center,
            position: LegendPosition.right,
            toggleSeriesVisibility: true,
            textStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF424242),
          series: <CircularSeries>[
            PieSeries<ChartData, String>(
              dataSource: chartData,
              pointColorMapper: (ChartData data, _) => data.color,
              enableTooltip: true,
              xValueMapper: (data, _) => data.text,
              yValueMapper: (data, _) => data.count,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                textStyle: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                labelIntersectAction: LabelIntersectAction.shift,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  String text;
  int count;
  Color color;

  ChartData({
    required this.text,
    required this.count,
    required this.color,
  });
}
