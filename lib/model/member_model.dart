import 'dart:convert';

class Member {
  final int id;
  final String name;
  final String? email;
  final String imageUrl;
  final int? kakaoId;
  final String status;
  final String jwt;

  Member({
    required this.id,
    required this.name,
    this.email,
    required this.imageUrl,
    required this.kakaoId,
    required this.status,
    required this.jwt,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String?,
      imageUrl: json['imageUrl'] as String,
      kakaoId: json['kakaoId'] as int?,
      status: json['status'] as String,
      jwt: json['jwt'] as String,
    );
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'kakaoId': kakaoId,
      'status': status,
      'jwt': jwt,
    };
  }

  factory Member.fromJsonString(String jsonString) {
    try {
      final Map<String, dynamic> data = jsonDecode(jsonString);
      return Member.fromJson(data);
    } catch (e) {
      print('fromJsonString 오류: $e');
      return Member(id: 0, name: '', imageUrl: '', status: '', jwt: '', kakaoId: 0); // 이 부분은 디폴트 값으로 반환하거나 적절한 에러 처리를 할 수 있습니다.
    }
  }
}
