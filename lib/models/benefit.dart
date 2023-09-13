class Benefit {
  String? id;
  String? name;
  int? points;
  String? file;
  String? extension;
  String? type;

  Benefit({
    this.id,
    this.name,
    this.points,
    this.file,
    this.extension,
    this.type,
  });

  Benefit.fromMap(Map<String, dynamic> benefitData)
      : id = benefitData['_id'],
        name = benefitData['name'],
        points = benefitData['points'],
        file = benefitData['file'],
        extension = benefitData['extension'],
        type = benefitData['type'];

  @override
  String toString() {
    return 'Benefit{id: $id, name: $name, points: $points, file: $file, extension: $extension, type: $type}';
  }
}
