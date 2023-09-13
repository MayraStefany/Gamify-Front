import 'package:flutter/material.dart';
import 'package:gamify_app/models/event_summary.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AreaChart extends StatefulWidget {
  final List<DetailEventSummary> datesDetail;
  const AreaChart({
    required this.datesDetail,
  });

  @override
  State<AreaChart> createState() => _AreaChartState();
}

class _AreaChartState extends State<AreaChart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: SizedBox(
        height: 200,
        child: SfCartesianChart(
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            zoomMode: ZoomMode.x,
            enablePanning: true,
          ),
          plotAreaBorderWidth: 0,
          title: ChartTitle(
            text: 'Tarea semanal',
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          legend: Legend(
            isVisible: false,
          ),
          primaryXAxis: CategoryAxis(
            majorGridLines: const MajorGridLines(width: 0),
            axisLine: const AxisLine(width: 1),
            labelStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          primaryYAxis: CategoryAxis(isVisible: false),
          backgroundColor: const Color(0xFF424242),
          series: <ChartSeries>[
            AreaSeries<DetailEventSummary, String>(
              color: kActiveColor.withOpacity(0.5),
              borderColor: kActiveColor,
              borderDrawMode: BorderDrawMode.top,
              borderWidth: 2,
              dataSource: widget.datesDetail,
              isVisibleInLegend: false,
              enableTooltip: true,
              xValueMapper: (data, _) =>
                  DateFormat('dd/MM/yy').format(DateTime.parse(data.date)),
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
