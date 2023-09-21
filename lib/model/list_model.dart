class Notice {
  int? noticeArticleId;
  String? title;
  String? content;
  String? image;
  bool isFavorite;

  Notice({
    this.noticeArticleId,
    this.title,
    this.content,
    this.image,
    this.isFavorite = false,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      noticeArticleId: json['noticeArticleId'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noticeArticleId'] = this.noticeArticleId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    return data;
  }
}
