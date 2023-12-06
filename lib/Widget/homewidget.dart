import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../apis.dart';
import '../main.dart';
import '../model/list_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/member_model.dart';


class HomeWidget extends StatefulWidget {
  final List<Map<String, dynamic>> userKeywords;
  final Member member;


  HomeWidget({required this.userKeywords, required this.member});

  @override
  State<StatefulWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<Notice> fetchedNotices = [];

  @override
  void initState() {
    super.initState();
    print('keyword 뭘 선택했더라~~~:${widget.userKeywords}');
    _fetchNotices();
  }

  void _fetchNotices() async {
    for (var keyword in widget.userKeywords) {
      final int keywordId = keyword['id'] as int;
      print('Keyword selected: $keywordId');
      List<Notice> keywordNotices = await APIs.fetchNoticesByKeyword(keywordId, widget.member.jwt);
      setState(() {
        fetchedNotices.addAll(keywordNotices);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
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
            _contentWidget(fetchedNotices),
          ],
        ),
      ),
    );
  }

  Widget _contentWidget(List<Notice> noticeList) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: noticeList.length,
      separatorBuilder: (BuildContext context, int index) => Divider(
        color: Colors.grey,
        height: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        Notice notice = noticeList[index];
        String shortTitle = notice.title ?? '';
        String shortContent = notice.content ?? '';

        if (shortTitle.length > 13) {
          shortTitle = shortTitle.substring(0, 13) + '...'; // Display up to 15 characters
        }

        if (shortContent.length > 17) {
          shortContent = shortContent.substring(0, 17) + '...'; // Display up to 10 characters
        }

        return ListTile(
          onTap: () {
            _launchURL(notice.link ?? '');
          },
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(notice.image ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            shortTitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(
            shortContent,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          trailing: IconButton(
            icon: notice.Favorite
                ? Icon(Icons.favorite, color: Color(0xffFF0000).withOpacity(0.45))
                : Icon(Icons.favorite_border, color: Color(0xffFF0000).withOpacity(0.45)),
            onPressed: () {
              setState(() {
                notice.Favorite = !notice.Favorite;
              });
            },
          ),
        );
      },
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
