import 'package:gamify_app/utils/utils.dart';

class Event {
  String? eventId;
  String? summary;
  String? description;
  String? startDate;
  String? endDate;
  Priority? priority;
  String? user;
  String? tokenInherited;
  bool? sent;
  bool? closed;
  bool? repeat;
  int? points;

  Event({
    this.eventId,
    this.summary,
    this.description,
    this.startDate,
    this.endDate,
    this.user,
    this.tokenInherited,
    this.priority,
    this.sent,
    this.closed,
    this.repeat,
    this.points,
  });

  Event.fromMap(Map<String, dynamic> eventData)
      : eventId = eventData['_id'],
        summary = eventData['summary'],
        description = eventData['description'],
        startDate = eventData['startDate'],
        endDate = eventData['endDate'],
        user = eventData['user'],
        tokenInherited = eventData['tokenInherited'],
        priority = Utils.enumFromString(eventData['priority'], Priority.values),
        sent = eventData['sent'],
        closed = eventData['closed'],
        repeat = eventData['repeat'],
        points = eventData['points'];

  Map<String, dynamic> toMapCreate() => {
        'summary': summary,
        'description': description,
        'startDate': startDate,
        'endDate': endDate,
        'priority': Utils.getValuePriority(priority),
        'user': user,
        'repeat': repeat
      };

  Map<String, dynamic> toMapEdit() => {
        'summary': summary,
        'description': description,
        'startDate': startDate,
        'endDate': endDate,
        'priority': Utils.getValuePriority(priority),
      };

  @override
  String toString() {
    return 'Event{eventId: $eventId, summary: $summary, description: $description, startDate: $startDate, endDate: $endDate, priority: $priority, user: $user, '
        'tokenInherited: $tokenInherited, sent: $sent, closed: $closed, repeat: $repeat, points: $points}';
  }
}
