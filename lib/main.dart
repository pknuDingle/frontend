import 'package:capstone_dingle/home.dart';
import 'package:flutter/material.dart';
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
  int _currentIndex = 0; //
  String _appBarTitle = 'HOME';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
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
            _currentIndex = index;
            if (index == 0) {
              _appBarTitle = 'HOME';
              Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
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
