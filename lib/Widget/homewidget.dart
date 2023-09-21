import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../list/list_mockdata.dart';
import '../main.dart';
import '../model/list_model.dart';
import '../suggestion.dart';
import '../category.dart';
import 'package:url_launcher/url_launcher.dart';


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
            padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 38),
            child: Text(
              'NOTICE LIST',
              style: TextStyle(color: Color(0xff9BBDFF), fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(height: 1, color: Color(0xffdedede)),
          _contentWidget(NoticeList)
        ],
      ),
    );
  }

  Widget _contentWidget(List<Notice> noticeList) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        Notice notice = noticeList[index];
        String shortTitle = notice.title ?? '';
        String shortContent = notice.content ?? '';

        if (shortTitle.length > 13) {
          shortTitle = shortTitle.substring(0, 13) + '...'; // 15글자까지만 표시
        }

        if (shortContent.length > 17) {
          shortContent = shortContent.substring(0, 17) + '...'; // 10글자까지만 표시
        }
        return ListTile(
          onTap: () {
            // 클릭한 공지사항이 noticelist5인 경우 해당 URL로 이동
            if (notice == noticelist5) {
              _launchURL('https://ce.pknu.ac.kr/ce/1814?action=view&no=9942231');
            }
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5, right: 10),
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(notice.image ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        shortTitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        shortContent,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: notice.isFavorite 
                    ? Icon(Icons.favorite,
                  color: Color(0xffFF0000).withOpacity(0.45),
                )
                    : Icon(Icons.favorite_border,
                  color: Color(0xffFF0000).withOpacity(0.45),),
                onPressed: () {
                  // 아이콘 상태 토글
                  setState(() {
                    notice.isFavorite = !notice.isFavorite;
                  });
                },
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(height: 1, color: Color(0xffdedede));
      },
      itemCount: noticeList.length,
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}


