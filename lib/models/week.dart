class Week {
  String id;
  int number;
  String start;
  String end;
  bool painted;

  Week({
    required this.id,
    required this.number,
    required this.start,
    required this.end,
    this.painted = false,
  });

  Week.fromMap(Map<String, dynamic> weekData)
      : id = weekData['_id'],
        number = weekData['number'],
        start = weekData['start'],
        end = weekData['end'],
        painted = false;

  @override
  String toString() {
    return 'Week{id: $id, number: $number, start: $start, end: $end, painted: $painted}';
  }
}
