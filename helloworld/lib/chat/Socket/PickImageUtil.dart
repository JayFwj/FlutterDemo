import 'package:image_picker/image_picker.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';

enum ActionItemStyle {defaultStyle, destructStyle}

//MARK:选择图片
class PickImageUtil extends Widget{

  final ValueChanged<dynamic> onChanged;

  PickImageUtil(@required this.onChanged);

  Future takePicture() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    onChanged(image);
  }

  Future getImageFromAlbum() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    onChanged(image);
  }

  //显示选择图片的对话框
  showPickImageActionSheet(BuildContext context){ 

    Widget actionItem(String title, bool showBottomLine, ActionItemStyle style){
      return Container(
        height: 50,
        child: Column(
          children: <Widget>[
            Expanded(child: Center(child:Text(title, style: TextStyle(color: style==ActionItemStyle.defaultStyle?Colors.black:Colors.red),)),) ,
            Container(height: showBottomLine ? 1 : 0, color: Colors.grey,
            )],
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
              takePicture();
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

  @override
  Element createElement() {
    // TODO: implement createElement
    return null;
  }
}