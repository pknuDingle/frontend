import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../main.dart';
import '../suggestion.dart';
import '../category.dart';


class JJIMWidget extends StatefulWidget{
  @override

  JJIMWidget();

  @override
  State<StatefulWidget> createState() => _JJIMWidgetState();

}

class _JJIMWidgetState extends State<JJIMWidget> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
          child: Text('메롱')
      ),
    );

  }

}