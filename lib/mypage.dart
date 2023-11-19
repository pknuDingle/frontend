import 'package:capstone_dingle/Widget/homewidget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'Login_page.dart';
import 'main.dart';
import 'package:capstone_dingle/suggestion.dart';
import 'category.dart';


void main() {
  runApp(MaterialApp(
    home: MyPage(),

  ));
}
class MyPage extends StatefulWidget {
  @override
  _inMyPage createState() => _inMyPage();
}

class _inMyPage extends State<MyPage> {

  @override
  File? _image;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery); // 从相册中选择照片

    setState(() {
      _image = pickedImage != null ? File(pickedImage.path) : null;
    });
  }


  Widget build(BuildContext context) {
    String email = '123456789@mail.com';
    String name = '홍길동';
    String lesson = '컴퓨터공학과';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text(
          'MY PAGE',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));//돌아가기
          },
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: _pickImage,
          child: Column(
            children: [
              Container(
                color: Colors.lightBlue,
                child: Row(
                  children: [
                    // 원쪽 이미지
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey, //이미지 없을때 unkown로 표시
                        image: _image != null
                            ? DecorationImage(
                          image: FileImage(_image!),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                      child: _image == null
                          ? Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.white,
                      )
                          : null,
                    ),
                    SizedBox(width: 16.0), // 좌우 간격
                    // 右侧信息
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name+'님',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          email,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          lesson,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('카테고리 수정'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // 导航到分类修改画面
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Categoly()));//돌아가기
                },
              ),
              ListTile(
                leading: Icon(Icons.feedback),
                title: Text('건의하기'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // 导航到建议画面
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Suggestion()));
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('탈퇴하기'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  //
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'JIIM',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'MY PAGE',
          ),
        ],
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => HomeWidget()));
          } else if (index == 1) {

          }
        },
      ),
    );
  }
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