import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gamify_app/models/event.dart';
import 'package:gamify_app/screens/activity/components/event_dialog.dart';
import 'package:gamify_app/services/event_service.dart';
import 'package:gamify_app/utils/app_state.dart';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/constans_assets.dart';
import 'package:gamify_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  final eventService = EventService.instance;
  List<Event>? events = [];
  bool isShowSpinner = false;
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> setData() async {
    setState(() => isShowSpinner = true);
    events!.clear();
    final user = Provider.of<AppState>(context, listen: false).user;
    events = await eventService.getEventsByUser(userId: user!.userId);
    setState(() => isShowSpinner = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                kCalendarMenuImagePath,
                width: 50,
              ),
              const SizedBox(
                width: 20,
              ),
              const Column(
                children: [
                  Text(
                    'CALENDARIO DE',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w400,
                      fontFamily: kBungeeFont,
                      color: kGrayColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'ACTIVIDADES',
                    style: TextStyle(
                      fontSize: 23,
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
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                    bottom: 60,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(
                        width: 2,
                        color: Color(0xFF676565),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: SfCalendar(
                        headerDateFormat: 'MMM y',
                        view: CalendarView.week,
                        initialDisplayDate: date,
                        onViewChanged: (ViewChangedDetails details) {
                          date = details.visibleDates.first;
                        },
                        dataSource: MeetingDataSource(events!),
                        todayHighlightColor: kActiveColor,
                        cellBorderColor: kGrayColor,
                        backgroundColor: Colors.black,
                        showNavigationArrow: true,
                        selectionDecoration: BoxDecoration(
                          border: Border.all(
                            color: kActiveColor,
                            width: 2,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                          shape: BoxShape.rectangle,
                        ),
                        onTap: (CalendarTapDetails c) {
                          if (c.appointments != null) {
                            if (c.appointments!.isNotEmpty) {
                              showCustomDialog(
                                context: context,
                                onRefresh: () => setData(),
                                event: c.appointments!.first,
                              );
                            }
                          }
                        },
                        cellEndPadding: 0,
                        appointmentTextStyle: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        headerStyle: const CalendarHeaderStyle(
                          textAlign: TextAlign.start,
                          backgroundColor: Color(0xFF413E3E),
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: kGrayColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        viewHeaderStyle: const ViewHeaderStyle(
                          backgroundColor: Color(0xFF413E3E),
                          dayTextStyle: TextStyle(
                            fontSize: 11,
                            color: kGrayColor,
                            fontWeight: FontWeight.w400,
                          ),
                          dateTextStyle: TextStyle(
                            fontSize: 11,
                            color: kGrayColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        timeSlotViewSettings: const TimeSlotViewSettings(
                          timeTextStyle: TextStyle(
                            fontSize: 11,
                            color: kGrayColor,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ],
    );
  }

  Future<void> showCustomDialog({
    required BuildContext context,
    required Function onRefresh,
    required Event event,
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
          content: EventDialog(
            event: event,
            onRefresh: onRefresh,
            dialogContext: dialogContext,
            mainContext: context,
          ),
        ),
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return DateTime.parse(appointments![index].startDate);
  }

  @override
  DateTime getEndTime(int index) {
    return DateTime.parse(appointments![index].endDate);
  }

  @override
  String getSubject(int index) {
    return appointments![index].summary;
  }

  @override
  Color getColor(int index) {
    return Utils.getColorByPriority(appointments![index].priority);
  }
}
