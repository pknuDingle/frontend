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
        backgroundColor: Colors.lightBlue,
        title: Text(
          '카테고리 수정',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
                leading: Icon(Icons.home),
                title: Text('홈페이지 수정'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // 홈패이지로 이동
                  Navigator.push(context, MaterialPageRoute(builder: (_) => homePageSetting()));
                },
              ),
              ListTile(
                leading: Icon(Icons.key),
                title: Text('키워드 수정'),
                trailing: Icon(Icons.arrow_forward),
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
