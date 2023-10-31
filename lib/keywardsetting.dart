import 'package:flutter/material.dart';
import 'category.dart';

void main() {
  runApp(keyWardSetting());
}

class keyWardSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyKeyWard(),
    );
  }
}

class MyKeyWard extends StatefulWidget {
  @override
  _MyKeyWardState createState() => _MyKeyWardState();
}

class _MyKeyWardState extends State<MyKeyWard> {
  //학사 선택 배열
  List<String> bachelorsDegree = [
    '근로',
    '졸업',
    '등록',
    '장학',
    '성적',
    '수강신청',
    '선적',
    '기숙사',
    '동아리',
    '휴학',
  ];
  List<String> selectedbachelorsDegree = [];

  //취업 선택 배열
  List<String> employment = [
    '취창업',
    '공모전',
    '실습',
    '교직',
    '어학',
  ];
  List<String> selectedemployment = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //패이지 제목
        backgroundColor: Color(0xFF9BBDFF),
        title: Text('키워드 선택',
        style: TextStyle(color: Colors.white,
        fontWeight: FontWeight.bold),
        ),

        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => Categoly()));//돌아가기
          },
        ),
      ),
      body: Center(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,// 중간 정렬
          children: <Widget>[
            Text(
              '정보를 받고싶은 \n키워드를 선택해주세요\n\n',
              style: TextStyle(
                fontSize: 24, // 글 사이즈
                fontWeight: FontWeight.bold, // 글꼴
              ),
            ),
            Wrap(

              spacing: 10.0,
              children: bachelorsDegree.map((university) {
                //학사 선택 되었는지
                bool isSelected = selectedbachelorsDegree.contains(university);
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (isSelected) {
                        //이미 선택된거 선택시 제거
                        selectedbachelorsDegree.remove(university);
                      } else {
                        //아니면 선택된다
                        selectedbachelorsDegree.add(university);
                      }
                    });
                  },
                  style: ButtonStyle(
                    //버튼 색갈
                    backgroundColor: MaterialStateProperty.all(
                      isSelected ? Colors.blue : Colors.white,
                    ),
                  ),
                  child: Text(university, style: TextStyle(color: Colors.black)),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,// 중간 정렬
              children: <Widget>[
                Text(
                  '\n\n 취업 진로 지원\n\n',
                  style: TextStyle(
                    fontSize: 24, // 글 사이즈
                    fontWeight: FontWeight.bold, // 글꼴
                  ),
                ),
                Wrap(
                  spacing: 10.0,
                  children: employment.map((university) {
                    //취업 선택 되었는지
                    bool isSelected = selectedemployment.contains(university);
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (isSelected) {
                            //이미 선택된거 선택시 제거
                            selectedemployment.remove(university);
                          } else {
                            //아니면 선택된다
                            selectedemployment.add(university);
                          }
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          isSelected ? Colors.blue : Colors.white,
                        ),
                      ),
                      child: Text(university, style: TextStyle(color: Colors.black)),
                    );
                  }).toList(),
                ),
                SizedBox(height: 200),

                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 400, // 가로 크기
                    height: 50, // 세로 크기
                    child: ElevatedButton(

                      onPressed: () {
                        showDialog(context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('선택 성공'),
                            );
                          },
                        );
                        //1초후 전패이지 로 이동동
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => Categoly()));// 초기 화면으로 이동
                        });
                      },
                      child: Text('확인'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // 라디안 조절
                        ),
                        primary: Color(0xFF9BBDFF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
