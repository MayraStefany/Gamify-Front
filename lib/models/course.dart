import 'package:gamify_app/models/course_record.dart';

class Course {
  String? courseId;
  String? name;
  List<CourseRecord>? records;

  Course({
    this.courseId,
    this.name,
    this.records,
  });

  Course.fromMap(Map<String, dynamic> courseData)
      : courseId = courseData['_id'],
        name = courseData['name'],
        records = courseData['records'] != null
            ? List<CourseRecord>.from(
                courseData['records']
                    .map((record) => CourseRecord.fromMap(record)),
              )
            : [];

  Map<String, dynamic> toMapCreate() => {
        'name': name,
        'records': records!.map((record) => record.toMapCreate()).toList(),
      };

  @override
  String toString() =>
      'Course{courseId: $courseId, name: $name, records: $records}';
}
