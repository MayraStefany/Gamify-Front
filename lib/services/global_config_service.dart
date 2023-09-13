import 'package:gamify_app/services/http_service.dart';
import 'package:gamify_app/utils/http_exception.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'dart:developer' as dev;

class GlobalConfigService {
  final globalConfigPath = 'global-config';

  static final GlobalConfigService _instance =
      GlobalConfigService._privateConstructor();
  static GlobalConfigService get instance => _instance;
  GlobalConfigService._privateConstructor();

  final _httpService = HttpService.instance;

  Future<String> getWeekId() async {
    try {
      dynamic weekId = await _httpService.get(
        globalConfigPath,
      );
      return weekId['week'];
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'GlobalConfigService.getWeekId');
      throw ServiceException(e.message);
    }
  }
}
