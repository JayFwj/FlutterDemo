import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

class ImageUpload extends StatefulWidget {
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('图片墙')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('长按可排序'),
          ),
          Expanded(
              child: Container(
            child: SyImageWall(
                reorderable: true,
                images: [
                  'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3168623339,791844963&fm=26&gp=0.jpg',
                  'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2313311800,1272044575&fm=26&gp=0.jpg',
                  'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2789842782,3425950486&fm=26&gp=0.jpg'
                ],
                onChange: (images) {
                  print(images);
                },
                onUpload: () async {
                  await Future.delayed(Duration(seconds: 1));
                  return 'http://qn.isanye.cn/avatar.png?ts=' +
                      DateTime.now().toIso8601String();
                }),
          )),
        ],
      ),
    );
  }
}
