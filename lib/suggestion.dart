import 'package:flutter/material.dart';
import 'mypage.dart';

void main() {
  runApp(Suggestion());
}

class Suggestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WriteSuggestion(),
    );
  }
}

class WriteSuggestion extends StatefulWidget {
  @override
  _WriteSuggestionState createState() => _WriteSuggestionState();
}

class _WriteSuggestionState extends State<WriteSuggestion> {
  String email = '';
  String title = '';
  String content = '';
  bool submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('건의하기'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => MyPage())); //돌아가기
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //이메일 입력------------
            Text(
              '이메일',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: '이메일 입력 ',
              ),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
            ),
            //재목 입력------------
            SizedBox(height: 16.0),
            Text(
              '재목',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: '문제점을 ',
              ),
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
            ),
            //내용 입력------------
            SizedBox(height: 16.0),//내용 입력
            Text(
              '내용',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 500, // 가로 크기
              height: 430, // 세로 크기
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '자세한 내용 입력',
                ),
                maxLines: 10,
                onChanged: (value) {
                  setState(() {
                    content = value;
                  });
                },
              ),
            ),
            // SizedBox(height: 32.0),
            Align(
              alignment: Alignment.bottomCenter, // 하단 정렬
              child: SizedBox(
                width: 500, // 가로 크기
                height: 30, // 세로 크기
                child: ElevatedButton(
                  onPressed: () {
                    //email、title,content제대로 죈지확인
                    print('건의하기：이메일：$email，제목：$title，내용：$content');
                    showDialog(context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('제출 성공'),
                        );
                      },
                    );
                    Future.delayed(Duration(seconds: 1), () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (_) => MyPage())); // 초기 화면으로 이동
                    });
                  },
                  child: Text('재출'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}