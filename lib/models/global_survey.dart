class GlobalSurvey {
  String? userId;
  int? participation;
  int? taskCompletion;
  int? timeManagement;

  GlobalSurvey({
    this.userId,
    this.participation,
    this.taskCompletion,
    this.timeManagement,
  });

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'participation': participation,
        'taskCompletion': taskCompletion,
        'timeManagement': timeManagement,
      };

  @override
  String toString() {
    return 'GlobalSurvey{userId: $userId, participation: $participation, taskCompletion: $taskCompletion, timeManagement: $timeManagement}';
  }
}
