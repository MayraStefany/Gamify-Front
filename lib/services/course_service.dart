import 'package:gamify_app/models/course.dart';
import 'package:gamify_app/services/http_service.dart';
import 'package:gamify_app/utils/http_exception.dart';
import 'package:gamify_app/utils/service_exception.dart';
import 'dart:developer' as dev;

class CourseService {
  final coursesPath = 'courses';

  static final CourseService _instance = CourseService._privateConstructor();
  static CourseService get instance => _instance;
  CourseService._privateConstructor();

  final _httpService = HttpService.instance;

  Future<List<Course>> getCourses() async {
    try {
      List<dynamic> data = await _httpService.get(
        coursesPath,
      );
      return data.map((e) => Course.fromMap(e)).toList();
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'CourseService.getCourses');
      throw ServiceException(e.message);
    }
  }

  Future<void> registerCourse({
    required Course course,
  }) async {
    try {
      await _httpService.post(
        coursesPath,
        params: {
          'courses': [course].map((c) => c.toMapCreate()).toList()
        },
      );
    } on HttpException catch (e) {
      dev.log(e.toString(), name: 'CourseService.registerCourse');
      throw ServiceException(e.message);
    }
  }
}
