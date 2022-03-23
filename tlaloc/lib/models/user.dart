class UserFields {
  static const String id = 'id';
  static const String author = 'author';
  static const String common = 'common';
  static const String measurement = 'Measurement';
  static const String date = 'date';
  static const String hour = 'hour';

  static List<String> getFields() => [id, author, common, measurement, date, hour];
}

class User {
  final int? id;
  final String author;
  final String common;
  final String measurement;
  final String date;
  final String hour;

  const User({
    this.id,
    required this.author,
    required this.common,
    required this.measurement,
    required this.date,
    required this.hour,
  });
  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.author: author,
        UserFields.common: common,
        UserFields.measurement: measurement,
        UserFields.date: date,
        UserFields.hour: hour,
      };
}
