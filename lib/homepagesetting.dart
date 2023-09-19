import 'package:flutter/material.dart';
import 'category.dart';


void main() {
  runApp(homePageSetting());
}

class homePageSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
// 대학 배열
class _MyHomePageState extends State<MyHomePage> {
  List<String> universities = [
    '인문사회대학',
    '자연과학대학',
    '경영대학',
    '공과대학',
    '수산과학대학',
    '환경.해양대학',
    '정보융합대학',
    '미래융합대학',
    '글로벌자율전공학부',
    '학부대학',
  ];
// 상세 전공 배열
  Map<String, List<String>> majorSubjects = {
    '인문사회대학': ['국어국문학과','영어영문학부','일어일문학부','사학과경제학과','법학과행정복지학부','국제지역학부','중국학과','정치외교학과','유아교육과','패션디자인학과','사회계열'],
    '자연과학대학': ['응용수학과','물리학과','화학과미생물학과','간호학과','과학컴퓨팅학과'],
    '경영대학': ['경영학부','국제통상학부'],
    '공과대학': ['전기공학부(전기공학전공)','전기공학부(제어계측공학전공)','전기공학부(디스플레이반도체공학전공)','기계공학부(기계공학전공)','기계공학부(기계설계공학전공)',
      '에너지수송시스템공학부(냉동공조공학전공)','에너지수송시스템공학부(기계시스템공학전공)','에너지수송시스템공학부(조선해양시스템공학전공)','화학공학과공업화학고분자공학부(공업화학전공)',
      '공업화학고분자공학부(고분자공학전공)','나노융합반도체공학부(나노융합공학전공)','나노융합반도체공학부(차세대반도체공학전공)','시스템경영안전공학부(산업경영공학전공)','시스템경영안전공학부(기술.데이터공학전공)',
      '시스템경영안전공학부(안전공학전공)','소방공학과융합소재공학부(금속공학전공)','융합소재공학부(재료공학전공)','융합소재공학부(신소재시스템공학전공)','건축공학과지속가능공학부(토목공학전공)','지속가능공학부(생태공학전공)'],
    '수산과학대학': ['식품과학부(식품공학전공)','식품과학부(식품영양학전공)','생물공학과','해양생산시스템관리학부','수산생명과학부(양식응용생명과학전공)','수산생명과학부(자원생물학전공)','수산생명의학과','수해양산업교육과',
      '해양수산경영경제학부(해양수산경영학전공)','해양수산경영경제학부(자원환경경제학전공)'],
    '환경.해양대학': ['지구환경시스템과학부(환경공학전공)','지구환경시스템과학부(해양학전공)','지구환경시스템과학부(환경지질과학전공)','지구환경시스템과학부(환경대기과학전공)','지구환경시스템과학부(공간정보시스템공학전공)','해양공학과','에너지자원공학과'],
    '정보융합대학': ['데이터정보과학부(빅데이터융합전공)','데이터정보과학부(통계·데이터사이언스전공)','미디어커뮤니케이션학부(언론정보전공)','미디어커뮤니케이션학부(휴먼ICT융합전공)','스마트헬스케어학부(의공학전공)','스마트헬스케어학부(해양스포츠전공)',
      '스마트헬스케어학부(휴먼바이오융합전공)','전자정보통신공학부(전자공학전공)','전자정보통신공학부(정보통신공학전공)','조형학부(건축학전공)','조형학부(공업디자인전공)','조형학부(시각디자인전공)','컴퓨터·인공지능공학부(컴퓨터공학전공, 인공지능전공)',
      '디지털금융학과','스마트모빌리티공학과'],
    '미래융합대학': ['융합인재개발학부(평생교육·상담학전공)','융합인재개발학부(경찰범죄심리학전공)','융합공학부(기계조선에너지시스템공학전공)','융합공학부(전기전자소프트웨어공학전공)'],
    '글로벌자율전공학부': [''],
    '학부대학': [''],
  };

  List<String> selectedUniversities = [];
  List<String?> selectedMajors = [null, null, null]; // 초기화된 DropdownButton 상태


  //대학 선택수량에 따라 그대학에 대한 전공 전부출력
  List<String> getAllSelectedMajors() {
    List<String> allMajors = [];
    for (String university in selectedUniversities) {
      allMajors.addAll(majorSubjects[university] ?? []);
    }
    return allMajors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('홈페이지 선택'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '정보를 받고싶은 페이지를 선택해주세요\n\n',
              style: TextStyle(
                fontSize: 24, // 글 사이즈
                fontWeight: FontWeight.bold, // 글꼴
              ),
            ),
            Text(
              '단대 홈패이지',
              style: TextStyle(
                fontSize: 15, // 글 사이즈
                fontWeight: FontWeight.bold, // 글꼴
              ),
            ),
            Wrap(
              spacing: 10.0,
              children: universities.map((university) {
                bool isSelected = selectedUniversities.contains(university);
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (isSelected) {
                        selectedUniversities.remove(university);
                        // 대학 버튼을 다시 클릭하면 DropdownButton 초기화
                        selectedMajors = [null, null, null];
                      } else {
                        selectedUniversities.add(university);
                        selectedMajors = [null, null, null];
                      }
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      isSelected ? Colors.blue : Colors.grey,
                    ),
                  ),
                  child: Text(university),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '\n\n학과 홈페이지',
                  style: TextStyle(
                    fontSize: 15, // 글 사이즈
                    fontWeight: FontWeight.bold, // 글꼴
                  ),
                ),
                for (int i = 0; i < 3; i++)
                  DropdownButton<String>(
                    value: selectedMajors[i],
                    hint: Text('제 ${i + 1} 순위'),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedMajors[i] = newValue;
                      });
                    },
                    items: getAllSelectedMajors()
                        .map<DropdownMenuItem<String>>((String subject) {
                      return DropdownMenuItem<String>(
                        value: subject,
                        child: Text(subject),
                      );
                    }).toList(),
                  ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,// 중간 정렬
                    children: <Widget>[
                      Text(
                        '\n\n\n\n',
                        style: TextStyle(
                          fontSize: 24, // 글 사이즈
                          fontWeight: FontWeight.bold, // 글꼴
                        ),
                      ),
                    ]),
                Align(
                  alignment: Alignment.bottomCenter, // 하단 정렬
                  child: SizedBox(
                    width: 500, // 가로 크기
                    height: 30, // 세로 크기
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('선택 성공'),
                            );
                          },
                        );
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => Categoly()));// 초기 화면으로 이동
                        });
                      },
                      child: Text('확인'),
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
