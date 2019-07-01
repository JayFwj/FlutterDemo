import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

enum ActionItemStyle {defaultStyle, destructStyle}

class ImagePickerVC extends StatefulWidget {
  @override
  _ImagePickerVCState createState() => _ImagePickerVCState();
}

class _ImagePickerVCState extends State<ImagePickerVC> {
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future getImageFromAlbum() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  showPickImageSheet(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min, // 设置最小的弹出
          children: <Widget>[
            new ListTile(
              leading: new Icon(Icons.photo_camera),
              title: new Text("Camera"),
              onTap: ()  {
                getImage();
              },
            ),
            new ListTile(
              leading: new Icon(Icons.photo_library),
              title: new Text("Gallery"),
              onTap: () {
                getImageFromAlbum();
              },
            ),
          ],
        );
      }
    );
  }

  showPickImageActionSheet(BuildContext context){ 

    Widget actionItem(String title, bool showBottomLine, ActionItemStyle style){
      return Container(
        height: 50,
        child: Column(
          children: <Widget>[
            Expanded(child: Center(child:Text(title, style: TextStyle(color: style==ActionItemStyle.defaultStyle?Colors.black:Colors.red),)),) ,
            Container(height: showBottomLine ? 1 : 0, color: Colors.grey,
            )]
            ,

        ),
      );
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: (){
                showAlertDialog(context);
                Navigator.pop(context);
              },
              child: actionItem("AlertDialog", true, ActionItemStyle.defaultStyle),
            ),

            InkWell(
              onTap: (){
                showSimpleDialog(context);
                Navigator.pop(context);
              },
              child: actionItem("SimpleDialog", true, ActionItemStyle.defaultStyle),
            ),

            InkWell(
              onTap: (){
                getImage();
                Navigator.pop(context);
              },
              child: actionItem("相机", true, ActionItemStyle.defaultStyle),
            ),
             InkWell(
              onTap: (){
                getImageFromAlbum();
                Navigator.pop(context);
              },
              child: actionItem("相册", true, ActionItemStyle.defaultStyle),
            ) ,

            InkWell(
              onTap: (){

                Navigator.pop(context);
              },
              child: Container(child: actionItem("取消", false, ActionItemStyle.destructStyle), margin: EdgeInsets.only(top: 0),),
            ) 
          ],
        );
      }
    );
  }

  //提醒对话框 确定，取消
  showAlertDialog(BuildContext context){
    showDialog(
    context: context,
    builder: (BuildContext context) {
     return AlertDialog(
      title: new Text('你确定要这样做吗?'),
      actions: <Widget>[
        new FlatButton(
          child: new Text('取消'),
          onPressed: () {
            Navigator.of(context).pop();
            print('取消');
          },
        ),
        new FlatButton(
          child: new Text('确定'),
          onPressed: () {
            Navigator.of(context).pop();
            print('确定');
          },
        )
      ],
    );
  }
);
}

  //简单对话框
  showSimpleDialog(BuildContext context){

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text('选择'),
          children: <Widget>[
            new SimpleDialogOption(
              child: new Text('选项 1'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new SimpleDialogOption(
              child: new Text('选项 2'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new SimpleDialogOption(
              child: new Text('选项 3'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Picker Example'),
        actions: <Widget>[
          InkWell(
            onTap: (){
              //getImageFromAlbum();
              //showPickImageSheet(context);
              showPickImageActionSheet(context);
            },
            child:Container(child: Center(child: Text("选择图片"),), margin: EdgeInsets.only(right: 20),), 
          )
        ],
      ),
      body: Center(
        child: _image == null
            ? Text('No image selected.')
            : Image.file(_image),
      ),
    );
  }
}
