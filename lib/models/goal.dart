import 'package:gamify_app/models/course.dart';

class Goal {
  String? id;
  String? title;
  String? description;
  String? userId;
  String? date;
  bool? complete;
  Course? course;

  Goal({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.date,
    this.complete,
    this.course,
  });

  Goal.fromMap(Map<String, dynamic> goalData)
      : id = goalData['_id'],
        title = goalData['title'],
        description = goalData['description'],
        userId = goalData['userId'],
        date = goalData['date'],
        complete = goalData['complete'],
        course = Course.fromMap(goalData['course']);

  Map<String, dynamic> toMapCreate() => {
        'userId': userId,
        'title': title,
        'description': description,
        'date': date,
        'courseId': course!.courseId,
      };

  @override
  String toString() {
    return 'Goal{id: $id, title: $title, description: $description, userId: $userId, date: $date, complete: $complete, course: $course}';
  }
}
