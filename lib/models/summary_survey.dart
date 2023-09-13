class SummarySurvey {
  int eventsDone;
  SurveyResult taskCompletion;
  SurveyResult timeManagement;
  SurveyResult participation;

  SummarySurvey({
    required this.eventsDone,
    required this.taskCompletion,
    required this.timeManagement,
    required this.participation,
  });

  SummarySurvey.fromMap(Map<String, dynamic> summarySurveyData)
      : eventsDone = summarySurveyData['eventsDone'],
        taskCompletion =
            SurveyResult.fromMap(summarySurveyData['taskCompletion']),
        timeManagement =
            SurveyResult.fromMap(summarySurveyData['timeManagement']),
        participation =
            SurveyResult.fromMap(summarySurveyData['participation']);

  @override
  String toString() {
    return 'SummarySurvey{eventsDone: $eventsDone, taskCompletion: $taskCompletion, timeManagement: $timeManagement, participation: $participation}';
  }
}

class SurveyResult {
  dynamic before;
  dynamic after;

  SurveyResult({
    required this.before,
    required this.after,
  });

  SurveyResult.fromMap(Map<String, dynamic> surveyResultData)
      : before = surveyResultData['before'],
        after = surveyResultData['after'];

  @override
  String toString() => 'SurveyResult(before: $before, after: $after)';
}
