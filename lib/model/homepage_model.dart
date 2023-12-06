class HomePage {
  final int id;
  final String name;
  final String url;

  HomePage({
    required this.id,
    required this.name,
    required this.url,
  });

  factory HomePage.fromJson(Map<String, dynamic> json) {
    return HomePage(
      id: json['id'] as int,
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }
}
