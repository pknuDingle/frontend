class Keyword {
  final int id;
  final String name;
  final String categoryType;

  Keyword({
    required this.id,
    required this.name,
    required this.categoryType,
  });

  factory Keyword.fromJson(Map<String, dynamic> json) {
    return Keyword(
      id: json['id'] as int,
      name: json['name'] as String,
      categoryType: json['categoryType'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryType': categoryType,
    };
  }
}
