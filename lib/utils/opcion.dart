class Option {
  String text;
  String value;

  Option({
    required this.text,
    required this.value,
  });

  @override
  String toString() {
    return 'Option{text: $text, value: $value}';
  }
}
