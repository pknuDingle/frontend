class Notice {
  int? noticeArticleId;
  String? title;
  String? content;
  String? image;
  String? link;
  bool Favorite;

  Notice({
    this.noticeArticleId,
    this.title,
    this.content,
    this.image,
    this.link,
    this.Favorite = false,
  });

  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      noticeArticleId: json['noticeArticleId'],
      title: json['title'],
      content: json['content'],
      image: json['image'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['noticeArticleId'] = this.noticeArticleId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['image'] = this.image;
    data['link'] = this.link;
    return data;
  }
}
