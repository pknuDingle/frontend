import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Widget/homewidget.dart';
import 'Widget/jjimwidget.dart';
import 'mypage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0; //
  String _appBarTitle = 'HOME';
  @override
  Widget build(BuildContext context) {

    List _pageWidget = [
      HomeWidget(),
      JJIMWidget(),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff9BBDFF),
        title: Text(_appBarTitle,
            style: TextStyle(color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
            )
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _pageWidget.elementAt(selectedIndex),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
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
            label: 'MYPAGE',
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
            if (index == 0) {
              _appBarTitle = 'HOME';
            } else if (index == 1) {
              _appBarTitle = 'JIIM';

            } else {
              _appBarTitle = 'MYPAGE';
              Navigator.push(context, MaterialPageRoute(builder: (_) => MyPage()));
            }
          });
        },
      ),
    );
  }
}