class RainEntry {
  final String id;
  final String author;
  final String common;
  final String measurement;
  final String date;
  final String imageUrl;
  final String hour;
  // final List<String> tags;

  const RainEntry({
    required this.id,
    required this.author,
    required this.common,
    required this.measurement,
    required this.date,
    required this.imageUrl,
    required this.hour,
    // this.tags,
  });

  factory RainEntry.fromJson(Map<String, dynamic> json) {
    return RainEntry(
      id: json['Id'],
      author: json['Author'],
      common: json['Common'],
      measurement: json['Measurement'],
      imageUrl: json['Image'],
      date: json['Date'],
      hour: json['Hour']
      // tags: json['tags']?.split(', '),
    );
  }
}