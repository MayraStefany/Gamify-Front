class CourseRecord {
  String weekId;
  List<String> topics;
  String? weekName;
  bool painted;
  int? number;

  CourseRecord({
    required this.weekId,
    required this.topics,
    this.weekName,
    this.painted = false,
    this.number,
  });

  CourseRecord.fromMap(Map<String, dynamic> courseRecordData)
      : weekId = courseRecordData['weekId'],
        topics = List<String>.from(courseRecordData['topics'] ?? []),
        weekName = courseRecordData['weekName'],
        painted = false;

  Map<String, dynamic> toMapCreate() => {
        'weekId': weekId,
        'topics': topics,
      };

  @override
  String toString() =>
      'CourseRecord{weekId: $weekId, topics: $topics, weekName: $weekName, painted: $painted, number: $number}';
}
