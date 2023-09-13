import 'package:gamify_app/models/event.dart';
import 'package:gamify_app/models/event_summary.dart';
import 'package:gamify_app/services/http_service.dart';
import 'package:gamify_app/utils/http_exception.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'dart:developer' as dev;

class EventService {
  final registerEventPath = 'events';
  final eventsByUserPath = 'events/users';

  static final EventService _instance = EventService._privateConstructor();
  static EventService get instance => _instance;
  EventService._privateConstructor();

  final _httpService = HttpService.instance;

  Future<void> registerEvent({
    required Event event,
  }) async {
    try {
      await _httpService.post(
        registerEventPath,
        params: event.toMapCreate(),
      );
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'EventService.registerEvent');
      throw ServiceException(e.message);
    }
  }

  Future<List<Event>> getEventsByUser({
    required String userId,
  }) async {
    try {
      List<dynamic> data = await _httpService.get(
        'events/user/$userId',
      );
      return data.map((eventData) => Event.fromMap(eventData)).toList();
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'EventService.getEventsByUser');
      throw ServiceException(e.message);
    }
  }

  Future<void> deleteEvent({
    required String eventId,
  }) async {
    try {
      await _httpService.delete(
        'events/$eventId',
      );
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'EventService.deleteEvent');
      throw ServiceException(e.message);
    }
  }

  Future<Event> getEvent({
    required String eventId,
  }) async {
    try {
      dynamic data = await _httpService.get(
        'events/$eventId',
      );
      return Event.fromMap(data);
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'EventService.getEvent');
      throw ServiceException(e.message);
    }
  }

  Future<void> updateEvent({
    required Event event,
  }) async {
    try {
      await _httpService.put(
        'events/${event.eventId}',
        params: event.toMapEdit(),
      );
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'EventService.updateEvent');
      throw ServiceException(e.message);
    }
  }

  Future<EventSummary> getEventSummary({
    required String userId,
  }) async {
    try {
      dynamic data = await _httpService.get(
        'events/user/$userId/summary',
      );
      return EventSummary.fromMap(data);
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'EventService.getEventSummary');
      throw ServiceException(e.message);
    }
  }

  Future<void> closeEvent({
    required String eventId,
  }) async {
    try {
      await _httpService.put(
        'events/$eventId/close',
      );
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'EventService.closeEvent');
      throw ServiceException(e.message);
    }
  }
}
