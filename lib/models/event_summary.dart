class EventSummary {
  int eventsDone;
  int eventsNoDone;
  List<DetailEventSummary> datesDetail;
  dynamic advance;

  EventSummary({
    required this.eventsDone,
    required this.eventsNoDone,
    required this.datesDetail,
    required this.advance,
  });

  EventSummary.fromMap(Map<String, dynamic> eventSummaryData)
      : eventsDone = eventSummaryData['eventsDone'],
        eventsNoDone = eventSummaryData['eventsNoDone'],
        datesDetail = eventSummaryData['datesDetail'] != null
            ? List<DetailEventSummary>.from(
                eventSummaryData['datesDetail'].map(
                    (dateDetail) => DetailEventSummary.fromMap(dateDetail)),
              )
            : [],
        advance = eventSummaryData['advance'];

  @override
  String toString() =>
      'EventSummary{eventsDone: $eventsDone, eventsNoDone: $eventsNoDone, datesDetail: $datesDetail, advance: $advance}';
}

class DetailEventSummary {
  String date;
  int count;

  DetailEventSummary({
    required this.date,
    required this.count,
  });

  DetailEventSummary.fromMap(Map<String, dynamic> detailEventSummaryData)
      : date = detailEventSummaryData['date'],
        count = detailEventSummaryData['count'];

  @override
  String toString() => 'DetailEventSummary{date: $date, count: $count}';
}
