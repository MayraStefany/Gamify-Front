import 'package:gamify_app/models/goal.dart';
import 'package:gamify_app/services/http_service.dart';
import 'package:gamify_app/utils/http_exception.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'dart:developer' as dev;

class GoalService {
  final registerGoalPath = 'goals';

  static final GoalService _instance = GoalService._privateConstructor();
  static GoalService get instance => _instance;
  GoalService._privateConstructor();

  final _httpService = HttpService.instance;

  Future<List<Goal>> getGoalsByUser({required String userId}) async {
    try {
      List<dynamic> data = await _httpService.get(
        'goals/user/$userId',
      );
      return data.map((e) => Goal.fromMap(e)).toList();
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'GoalService.getGoalsByUser');
      throw ServiceException(e.message);
    }
  }

  Future<Goal> getGoal({
    required String goalId,
  }) async {
    try {
      dynamic data = await _httpService.get(
        'goals/$goalId',
      );
      return Goal.fromMap(data);
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'GoalService.getGoal');
      throw ServiceException(e.message);
    }
  }

  Future<void> completeGoal({
    required String goalId,
  }) async {
    try {
      await _httpService.put(
        'goals/$goalId/complete',
      );
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'GoalService.completeGoal');
      throw ServiceException(e.message);
    }
  }

  Future<void> registerGoal({
    required Goal goal,
  }) async {
    try {
      await _httpService.post(
        registerGoalPath,
        params: goal.toMapCreate(),
      );
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'GoalService.registerGoal');
      throw ServiceException(e.message);
    }
  }
}
