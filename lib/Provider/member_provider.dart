import 'package:shared_preferences/shared_preferences.dart';

import '../model/member_model.dart';

//...

Future<void> saveMemberInfo(Member member) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // Member 객체를 JSON 문자열로 변환하여 저장
  final String memberJson = member.toJsonString(); // 이 부분은 Member 클래스에 toJsonString() 메소드를 추가해야 합니다.

  // SharedPreferences에 Member 정보를 저장
  await prefs.setString('member_info', memberJson);
}

Future<Member?> getSavedMemberInfo() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  // SharedPreferences에서 저장된 Member 정보를 가져오기
  final String? memberJson = prefs.getString('member_info');

  if (memberJson != null && memberJson.isNotEmpty) {
    // JSON 문자열을 Member 객체로 변환하여 반환
    return Member.fromJsonString(memberJson); // Member 클래스에 fromJsonString() 메소드를 추가해야 합니다.
  } else {
    return null;
  }
}
