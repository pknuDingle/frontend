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
        backgroundColor: Colors.lightBlue,
        title: Text(
          'MY PAGE',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => MainPage()));//돌아가기
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
            Navigator.push(context, MaterialPageRoute(builder: (_) => MainPage()));
          } else if (index == 1) {

          }
        },
      ),
    );
  }
}
