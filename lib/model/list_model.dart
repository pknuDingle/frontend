class Notice {
  int? noticeArticleId;
  String? title;
  String? content;
  String? image; // 이미지 URL을 담는 필드

  Notice({
    this.noticeArticleId,
    this.title,
    this.content,
    this.image, // 생성자에도 추가
  });

  Notice.fromJson(Map<String, dynamic> json) {
    noticeArticleId = json['noticeArticleId'];
    title = json['title'];
    content = json['content'];
    image = json['imageUrl'];
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
