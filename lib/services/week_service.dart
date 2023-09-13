import 'package:gamify_app/models/week.dart';
import 'package:gamify_app/services/http_service.dart';
import 'package:gamify_app/utils/http_exception.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'dart:developer' as dev;

class WeekService {
  final weeksPath = 'weeks';

  static final WeekService _instance = WeekService._privateConstructor();
  static WeekService get instance => _instance;
  WeekService._privateConstructor();

  final _httpService = HttpService.instance;

  Future<List<Week>> getWeeks() async {
    try {
      List<dynamic> data = await _httpService.get(
        weeksPath,
      );
      return data.map((e) => Week.fromMap(e)).toList();
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'WeekService.getWeeks');
      throw ServiceException(e.message);
    }
  }
}
