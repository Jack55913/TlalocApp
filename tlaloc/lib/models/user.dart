class UserFields {
  static const String id = 'id';
  static const String author = 'author';
  static const String common = 'common';

  static List<String> getFields() => [id, author, common];
}

class User {
  final int? id;
  final String author;
  final String common;

  const User({
    this.id,
    required this.author,
    required this.common,
  });
  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.author: author,
        UserFields.common: common,
      };
}
