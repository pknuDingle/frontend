import 'dart:convert';
import 'package:capstone_dingle/model/list_model.dart';
import 'package:http/http.dart' as http;

import 'model/keyword_model.dart';
import 'model/member_model.dart';

class APIs {

  //카카오 로그인/회원가입
  static Future<Member?> signInWithKakao(String accessToken, String fcmToken) async {
    final url = Uri.parse('http://43.200.163.220:8080/kakao');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'AccessToken': '$accessToken',
          'FCM-Token': '$fcmToken',
        },
      );

      if (response.statusCode == 200|| response.statusCode == 202) {
        final Map<String, dynamic> userData = jsonDecode(response.body);
        final Member member = Member.fromJson(userData);

        print('카카오 로그인 성공: $member');
        print('카카오 로그인 성공:');
        print('ID: ${member.id}');
        print('Name: ${member.name}');
        print('Email: ${member.email}');
        print('Image URL: ${member.imageUrl}');
        print('Kakao ID: ${member.kakaoId}');
        print('Status: ${member.status}');
        print('JWT: ${member.jwt}');
        return member;
      } else {
        print('카카오 로그인 실패: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  // 키워드 보내기
  static Future<void> postKeyword(List<String> keywords, String jwt) async {
    final url = Uri.parse('http://43.200.163.220:8080/keyword');

    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': '$jwt',
        },
        body: jsonEncode(<String, dynamic>{
          'keywords': keywords,
        }),
      );

      print('Request URL: $url');
      print('Request Headers: ${jsonEncode(<String, String>{
        'Content-Type': 'application/json',
        'Authorization': '$jwt',
      })}');
      print('Request Body: ${jsonEncode(<String, dynamic>{'keywords': keywords})}');

      if (response.statusCode == 200||response.statusCode == 204) {
        print('키워드 업데이트 성공');
        print('Response Body: ${response.body}');
        print('키워드 업데이트 성공: ${response.statusCode}');
      } else {
        print('키워드 업데이트 실패: ${response.statusCode}');
        print('Response Body: ${response.body}');
        // 실패 시 추가적인 처리
      }
    } catch (e) {
      print('키워드 업데이트 실패: $e');
      // 예외 발생 시 추가적인 처리
    }
  }

  //홈페이지 설정하기
  static Future<void> setHomePage(List<int> homepageIds, String jwtToken) async {
    final url = Uri.parse('http://43.200.163.220:8080/homepage');

    try {
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $jwtToken',
        },
        body: jsonEncode(<String, dynamic>{
          'homepageIds': homepageIds,
        }),
      );

      if (response.statusCode == 200) {
        print('홈페이지 설정 업데이트 성공');
      } else {
        print('홈페이지 설정 업데이트 실패: ${response.statusCode}');
        // 실패 시 추가적인 처리
      }
    } catch (e) {
      print('홈페이지 설정 업데이트 실패: $e');
      // 예외 발생 시 추가적인 처리
    }
  }

  //키워드 조회하기
  static Future<List<Map<String, dynamic>>?> getUserKeywords(String jwtToken) async {
    final url = Uri.parse('http://43.200.163.220:8080/keyword');

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': '$jwtToken',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> keywordList = json.decode(response.body);

        // List<Map<String, dynamic>>로 변환
        List<Map<String, dynamic>> userKeywords = [];

        for (dynamic keywordData in keywordList) {
          Keyword keyword = Keyword.fromJson(keywordData);
          userKeywords.add(keyword.toJson());
        }
        print('키워드 불러오기 성공!: $userKeywords');
        return userKeywords;
      } else {
        print('Failed to fetch user keywords: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Failed to fetch user keywords: $e');
      return null;
    }
  }

  //공지리스트 받아오기
  static Future<List<dynamic>?> getFilteredNotices(String userId) async {
    final url = Uri.parse('http://43.200.163.220:8080/notice/all/user?userId=$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('조회성공');
        return data; // 필터링된 공지사항 리스트 반환
      } else {
        return null;
      }
    } catch (e) {
      print('실패:$e');
      return null;
    }
  }


  //keyword별 notice 조회
  static Future<List<Notice>> fetchNoticesByKeyword(int keywordId, String jwtToken) async {
    final Uri url = Uri.parse('http://43.200.163.220:8080/notice/keyword?keywordId=$keywordId');

    try {
      final response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': '$jwtToken',
          // 다른 헤더도 추가할 수 있으면 여기에 추가합니다.
        },
      );
      print('zzz $keywordId');

      if (response.statusCode == 200) {
        List<dynamic> decodedNotices = json.decode(utf8.decode(response.bodyBytes));
        List<Notice> notices = decodedNotices.map((json) => Notice.fromJson(json)).toList();
        print('성공${response.body}');
        return notices;
      } else {
        print('Failed to fetch notices. Error: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching notices: $e');
      return [];
    }
  }


  //회원 정보 받아오기
  static Future<Map<String, dynamic>> getUserInfo() async {
    final url = Uri.parse('http://43.200.163.220:8080');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = jsonDecode(response.body);
        return userData;
      } else {
        // 서버로부터 다른 응답을 받았을 때의 처리
        return {'error': 'Failed to load user data'};
      }
    } catch (e) {
      print('Error: $e');
      // 요청에 실패했을 때의 처리
      return {'error': 'Failed to connect to the server'};
    }
  }




}



