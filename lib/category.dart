import 'package:flutter/material.dart';
import 'mypage.dart';
import 'homepagesetting.dart';
import 'keywardsetting.dart';

void main() {
  runApp(MaterialApp(
    home: Categoly(),

  ));
}
class Categoly extends StatefulWidget {
  @override
  _inCategoly createState() => _inCategoly();
}

class _inCategoly extends State<Categoly> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF9BBDFF),
        title: Text(
          '카테고리 수정',
          style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold),// 굵게
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => MyPage()));//돌아가기
          },
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.house_outlined),
                title: Text('홈페이지 수정',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  // 홈패이지로 이동
                  Navigator.push(context, MaterialPageRoute(builder: (_) => homePageSetting()));
                },
              ),
              ListTile(
                leading: Icon(Icons.vpn_key_outlined),
                title: Text('키워드 수정',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  // 키워드로 이동
                  Navigator.push(context, MaterialPageRoute(builder: (_) => keyWardSetting()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
