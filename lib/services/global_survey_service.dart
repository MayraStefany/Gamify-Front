import 'package:gamify_app/models/global_survey.dart';
import 'package:gamify_app/services/http_service.dart';
import 'package:gamify_app/utils/http_exception.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'dart:developer' as dev;

class GlobalSurveyService {
  final createGlobalSurveyPath = 'global-surveys';

  static final GlobalSurveyService _instance =
      GlobalSurveyService._privateConstructor();
  static GlobalSurveyService get instance => _instance;
  GlobalSurveyService._privateConstructor();

  final _httpService = HttpService.instance;

  Future<void> createGlobalSurvey({
    required GlobalSurvey globalSurvey,
  }) async {
    try {
      await _httpService.post(
        createGlobalSurveyPath,
        params: globalSurvey.toMap(),
      );
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'GlobalSurveyService.createGlobalSurvey');
      throw ServiceException(e.message);
    }
  }
}
