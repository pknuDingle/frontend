import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'main.dart';
import 'suggestion.dart';
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
        backgroundColor: Color(0xFF9BBDFF),
        title: Text(
          'MY PAGE',
          style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold), // 굵게
        ),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => MainPage()));//돌아가기
          },
        ),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(


          child: Column(
            children: [
              SizedBox(height: 16.0),
              Container(
                width: 400,
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xFF9BBDFF),
                  borderRadius: BorderRadius.circular(20),//박스라디안
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,//그림자 색갈
                      blurRadius: 10,//그림자 라디안
                      offset: Offset(0, 4),//그림자 offset
                    ),
                  ],
                ),

                child: Row(
                  children: [
                  GestureDetector(
                    onTap: _pickImage,//선택시 엘범 열기
                    // 원쪽 이미지
                   child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: _image != null//이미지 없을때 unkown로 표시
                            ? DecorationImage(
                          image: FileImage(_image!),
                          fit: BoxFit.cover,
                        )
                            : null,
                      ),
                      child: _image == null
                          ? Icon(
                        Icons.face,
                        size: 100,
                        color: Colors.white,
                      )
                          : null,
                    ),
                  ),
                    SizedBox(width: 16.0), // 좌우 간격
                    // 오른쪽
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 25.0),
                        Row(
                          children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 30.0, // 크기
                            fontWeight: FontWeight.bold, // 굵게
                            color: Colors.white,
                          ),
                        ),
                            Text(
                              '님',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
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
                leading: Icon(Icons.edit_outlined),
                title: Text('카테고리 수정',
                style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  // 카테고리 이동
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Categoly()));//돌아가기
                },
              ),
              ListTile(
                leading: Icon(Icons.send_outlined),
                title: Text('건의하기',
                  style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  // 건의하기 이동
                  Navigator.push(context, MaterialPageRoute(builder: (_) => Suggestion()));
                },
              ),
              ListTile(
                leading: Icon(Icons.sentiment_neutral),
                title: Text('탈퇴하기',
                  style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(Icons.keyboard_arrow_right),
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
            Navigator.push(context, MaterialPageRoute(builder: (_) => MainPage()));
          } else if (index == 1) {
            //찝으로 이동
          }
        },
      ),
    );
  }
}
