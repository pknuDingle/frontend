import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'main.dart';
import 'suggestion.dart';
import 'category.dart';


void main() {
  runApp(MaterialApp(
    home: HomePage(),

  ));
}
class HomePage extends StatefulWidget {
  @override
  _inMyPage createState() => _inMyPage();
}

class _inMyPage extends State<HomePage> {

  @override



  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text(
          'Home',
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
        currentIndex: 0,
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
