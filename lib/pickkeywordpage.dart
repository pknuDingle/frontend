import 'package:capstone_dingle/home_page.dart';
import 'package:capstone_dingle/list/keyword_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/services.dart';

class PickKeywordPage extends StatefulWidget {
  @override
  _PickKeywordPageState createState() => _PickKeywordPageState();
}

class _PickKeywordPageState extends State<PickKeywordPage> {

  List<String> selectedkey1 = [];
  List<String> selectedkey2 = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 40, right: 12, left: 12, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '정보를 받고 싶은\n키워드를 선택해주세요.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '중복 선택 가능',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xffD9D9D9),
              ),
            ),
            SizedBox(height: 35),
            Text(
              '학사',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Wrap(
              children: key1.map((condition) {
                final bool isSelected = selectedkey1.contains(condition);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(
                      condition,
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected ? Colors.white : Color(0xff9BBDFF),
                      ),
                    ),
                    selected: isSelected,
                    backgroundColor: isSelected ? Color(0xff9BBDFF) : Colors.white,
                    selectedColor: Color(0xff9BBDFF),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedkey1.add(condition); // 선택된 항목을 추가
                        } else {
                          selectedkey1.remove(condition); // 선택 취소된 항목을 제거
                        }
                      });
                    },
                    labelPadding: EdgeInsets.only(left: 12, right: 12),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff9BBDFF),
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 35),
            Text(
              '취업 진로 지원',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Wrap(
              children: key2.map((condition) {
                final bool isSelected = selectedkey2.contains(condition);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(
                      condition,
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected ? Colors.white : Color(0xff9BBDFF),
                      ),
                    ),
                    selected: isSelected,
                    backgroundColor: isSelected ? Color(0xff9BBDFF) : Colors.white,
                    selectedColor: Color(0xff9BBDFF),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedkey2.add(condition); // 선택된 항목을 추가
                        } else {
                          selectedkey2.remove(condition); // 선택 취소된 항목을 제거
                        }
                      });
                    },
                    labelPadding: EdgeInsets.only(left: 12, right: 12),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Color(0xff9BBDFF),
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                );
              }).toList(),
            ),

            Expanded(child: SizedBox()),
            Container(
              width: double.maxFinite,
              height: 42,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff9BBDFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                  onPressed: (){
                    //print(user.toJson());
                    List<String> Keywords = [...selectedkey1, ...selectedkey2];
                    print('Keywords: $Keywords');
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text('확인')),
            )

          ],
        ),
      ),
    );
  }
}
