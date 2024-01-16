class DbRecord {
  final String id;
  final Map<String, dynamic> data;

  DbRecord({
    required this.id,
    this.data = const {},
  });
}
