import 'dart:io';
import 'package:gamify_app/models/benefit.dart';
import 'package:gamify_app/services/http_service.dart';
import 'package:gamify_app/utils/http_exception.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'dart:developer' as dev;

class BenefitService {
  final benefitsPath = 'benefits';
  final buyBenefitPath = 'benefits/buy';

  static final BenefitService _instance = BenefitService._privateConstructor();
  static BenefitService get instance => _instance;
  BenefitService._privateConstructor();

  final _httpService = HttpService.instance;

  Future<List<Benefit>> getBenefits() async {
    try {
      List<dynamic> data = await _httpService.get(
        benefitsPath,
      );
      return data.map((e) => Benefit.fromMap(e)).toList();
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'BenefitService.getBenefits');
      throw ServiceException(e.message);
    }
  }

  Future<List<Benefit>> getMyBenefits({
    required String userId,
  }) async {
    try {
      List<dynamic> data = await _httpService.get(
        'benefits/user/$userId',
      );
      return data.map((e) => Benefit.fromMap(e)).toList();
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'BenefitService.getMyBenefits');
      throw ServiceException(e.message);
    }
  }

  Future<int> buyBenefit({
    required String userId,
    required String benefitId,
  }) async {
    try {
      Map<String, dynamic> data = await _httpService.post(
        buyBenefitPath,
        params: {
          'userId': userId,
          'benefitId': benefitId,
        },
      );
      return data['points'];
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'BenefitService.buyBenefit');
      throw ServiceException(e.message);
    }
  }

  Future<void> registerBenefit({
    required Benefit benefit,
    required File file,
  }) async {
    try {
      await _httpService.postFile(
        path: 'benefits',
        file: file,
        params: {
          'name': '${benefit.name}',
          'points': '${benefit.points}',
        },
      );
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'BenefitService.registerBenefit');
      throw ServiceException(e.message);
    }
  }
}
