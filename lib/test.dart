import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('带阴影效果的有弧度的长方形'),
        ),
        body: Center(
          child: ShadowedRoundedRectangle(),
        ),
      ),
    );
  }
}

class ShadowedRoundedRectangle extends StatefulWidget {
  @override
  _ShadowedRoundedRectangleState createState() => _ShadowedRoundedRectangleState();
}

class _ShadowedRoundedRectangleState extends State<ShadowedRoundedRectangle> {
  ImagePicker _picker = ImagePicker();
  String _imagePath = 'your_image.png';

  Future<void> _pickImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // 长方形宽度
      height: 150, // 长方形高度
      decoration: BoxDecoration(
        color: Colors.white, // 长方形的背景颜色
        borderRadius: BorderRadius.circular(20), // 圆角半径
        boxShadow: [
          BoxShadow(
            color: Colors.grey, // 阴影颜色
            blurRadius: 10, // 模糊半径
            offset: Offset(0, 4), // 阴影偏移
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _pickImage, // 点击图片时触发选择图片操作
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                image: DecorationImage(
                  image: AssetImage(_imagePath), // 图片路径
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                '右半部分的文字',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
