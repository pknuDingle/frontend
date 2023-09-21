import 'package:capstone_dingle/Widget/homewidget.dart';
import 'package:flutter/material.dart';
import 'Widget/jjimwidget.dart';
import 'mypage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
