import 'package:capstone_dingle/pickkeywordpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/services.dart';

import 'list/department_list.dart';

class PickHomePage extends StatefulWidget {
  @override
  _PickHomePageState createState() => _PickHomePageState();
}

class _PickHomePageState extends State<PickHomePage> {
  List<String> whatUni = [
    '인문사회과학대', '자연과학대', '경영대', '공과대', '수산과학대', '환경해양대',
    '정보융합대', '미래융합대', '글로벌자율전공학부', '학부대'
  ];
  String selectedUni = '';
  String? tempPickedDepart = '국어국문학과';
  var _selectedDepart = '';
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '홈페이지',
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
              '정보를 받고 싶은\n홈페이지를 선택해주세요.',
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
              '단대 홈페이지',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Wrap(
              children: whatUni.map((condition) {
                final bool isSelected = selectedUni == condition;
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
                        selectedUni = selected ? condition : '';
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
              '학과 홈페이지',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Form(
                key: _formKey1,
                child: GestureDetector(
                  onTap: (){
                    HapticFeedback.mediumImpact();
                    _selectDepart();
                  },
                  child: Column(
                      children: [
                        TextFormField(
                          decoration: new InputDecoration(
                              hintText: '학과',
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("${_selectedDepart}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                  IconButton(
                                    icon: Icon(Icons.expand_more),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              hintStyle: TextStyle(fontSize: 16, color: Colors.black)
                          ),
                          //validator : (value) => value!.isEmpty? "Please enter some text" : null,
                          enabled: false,
                        )
                      ]
                  ),
                )
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PickKeywordPage()));
                  },
                  child: Text('확인')),
            )

          ],
        ),
      ),
    );
  }
  _selectDepart() async{
    String? pickedDepart = await showModalBottomSheet<String>(
      context: context,
      builder:  (context){
        return Container(
            child: Column(
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        child: Text('취소'),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoButton(
                        child: Text('완료'),
                        onPressed: (){
                          Navigator.of(context).pop(tempPickedDepart);
                        },
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  thickness: 1,
                ),
                Expanded(
                    child: CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: 30,
                      onSelectedItemChanged: (int selectedItem) {
                        print(whatDepart[selectedItem]);
                        setState(() {
                          tempPickedDepart = whatDepart[selectedItem];
                        });
                      },
                      children:
                      List<Widget>.generate(78, (int index) {
                        return Center(child: Text(whatDepart[index]));
                      }),
                    )
                ),
              ],
            )
        );
      },
    );
    if(pickedDepart != null && pickedDepart != _selectedDepart){
      setState((){
        _selectedDepart = pickedDepart;
      });
    }
  }
}
