import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../main.dart';
import '../suggestion.dart';
import '../category.dart';


class HomeWidget extends StatefulWidget{
  @override

  HomeWidget();

  @override
  State<StatefulWidget> createState() => _HomeWidgetState();

}

class _HomeWidgetState extends State<HomeWidget> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left:20, right:20, top: 10, bottom: 38),
            child: Text('NOTICE LIST',
        style: TextStyle(color:Color(0xff9BBDFF), fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Container(height: 1, color: Color(0xffdedede)),
         _contentwidget()
        ],
      ),
    );

  }

  Widget _contentwidget(){
    return ListView.separated(
      shrinkWrap: true, // shrinkWrap 설정 추가
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/baekgyeong.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text("Item $index"),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index){
        return Container(height: 1, color: Color(0xffdedede));
      },
      itemCount: 10,
    );
  }


}

