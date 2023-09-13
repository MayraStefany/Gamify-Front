import 'package:gamify_app/models/summary_survey.dart';
import 'package:gamify_app/models/survey.dart';
import 'package:gamify_app/services/http_service.dart';
import 'package:gamify_app/utils/http_exception.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'dart:developer' as dev;

class SurveyService {
  final createSurveyPath = 'surveys';

  static final SurveyService _instance = SurveyService._privateConstructor();
  static SurveyService get instance => _instance;
  SurveyService._privateConstructor();

  final _httpService = HttpService.instance;

  Future<void> createSurvey({
    required Survey survey,
  }) async {
    try {
      await _httpService.post(
        createSurveyPath,
        params: survey.toMap(),
      );
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'SurveyService.createSurvey');
      throw ServiceException(e.message);
    }
  }

  Future<List<Survey>> getSurveysDoneByUserId({required String userId}) async {
    try {
      List<dynamic> data = await _httpService.get(
        'surveys/user/$userId',
      );
      return data.map((e) => Survey.fromMap(e)).toList();
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'SurveyService.getSurveysDoneByUserId');
      throw ServiceException(e.message);
    }
  }

  Future<SummarySurvey> getSummarySurvey({
    required String userId,
  }) async {
    try {
      Map<String, dynamic> data = await _httpService.get(
        'surveys/user/$userId/summary',
      );
      return SummarySurvey.fromMap(data);
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'SurveyService.getSummarySurvey');
      throw ServiceException(e.message);
    }
  }
}
