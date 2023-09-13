class Survey {
  String? surveyId;
  String? userId;
  String? weekId;
  int? timeManagement;
  int? participation;

  Survey({
    this.surveyId,
    this.userId,
    this.weekId,
    this.timeManagement,
    this.participation,
  });

  Survey.fromMap(Map<String, dynamic> surveyData)
      : surveyId = surveyData['_id'],
        userId = surveyData['userId'],
        weekId = surveyData['weekId'],
        timeManagement = surveyData['timeManagement'],
        participation = surveyData['participation'];

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'weekId': weekId,
        'timeManagement': timeManagement,
        'participation': participation,
      };

  @override
  String toString() {
    return 'Survey{surveyId: $surveyId, userId: $userId, weekId: $weekId, timeManagement: $timeManagement, participation: $participation}';
  }
}
