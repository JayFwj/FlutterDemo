import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

//MARK:头像
class MsvCellAvatarView extends StatelessWidget{
 
  bool receivedMsg = false;
  String avatar;
  MsvCellAvatarView(this.receivedMsg, this.avatar);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     var avatarView = CachedNetworkImage(
          imageUrl: avatar,
          placeholder: (context, url) => new CircularProgressIndicator(),
          errorWidget: (context, url, error) => new Icon(Icons.error),
          width: 42,
          fit: BoxFit.fill,
    );
    var avatarContainer = Container(
          margin: EdgeInsets.fromLTRB(receivedMsg?10:0, 0, receivedMsg?0:10, 0),
          child: avatarView,
          width: 42,
          height: 42,
        ); 
    return avatarContainer;
  }
}

//MARK:文本消息
class TxtMsgView extends StatelessWidget{
  String avatar;
  String txt;
  bool receivedMsg = false;
  TxtMsgView(this.txt, this.receivedMsg, this.avatar);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var avatarContainer = MsvCellAvatarView(this.receivedMsg, this.avatar);

    var txt = Text(this.txt,
    style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
    textAlign: receivedMsg ? TextAlign.left : TextAlign.right,);

    var txtcontainer = Container(child: txt,
    // width: 200,
    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width -  90),
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.fromLTRB(receivedMsg?8:0, 0, receivedMsg?0:8, 0),
    decoration: BoxDecoration(  
        color: Colors.white,
        border: Border.all(color: Colors.grey.withAlpha(100), width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(offset: Offset(0,0), blurRadius: 1,spreadRadius: 1,color: Colors.grey.withAlpha(20))
        ]
      ) );
    var fillView = Flexible(child: Container(),);

    if(receivedMsg){
      var rowView = Row(children: <Widget>[
        avatarContainer,
        txtcontainer,
        fillView
      ],
      crossAxisAlignment: CrossAxisAlignment.start); 
    return Container(child: rowView, margin: EdgeInsets.only(right: 10, top: 10),);
    }else{
      var rowView = Row(children: <Widget>[
        fillView,
        txtcontainer,
        avatarContainer

      ],
      crossAxisAlignment: CrossAxisAlignment.start,); 
    return Container(child: rowView, margin: EdgeInsets.only(left: 10, top: 10),);
    }
  }
}

//MARK:图片消息
class ImgMsgView extends StatelessWidget{
  String avatar;
  String url;
  File imageFile;
  bool receivedMsg = false;
  ImgMsgView(this.receivedMsg, this.avatar,{this.url, this.imageFile});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var avatarContainer = MsvCellAvatarView(this.receivedMsg, this.avatar);

    Image imageView;
    if(this.url != null){
      imageView = Image.network(url);
    }else{
      imageView = Image.file(imageFile);
    }
    
    var txtcontainer = Container(child: imageView,
    // width: 200,
    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.35),
    padding: EdgeInsets.all(8),
    margin: EdgeInsets.fromLTRB(receivedMsg?8:0, 0, receivedMsg?0:8, 0),
    decoration: BoxDecoration(  
        color: Colors.white,
        border: Border.all(color: Colors.grey.withAlpha(100), width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(offset: Offset(0,0), blurRadius: 1,spreadRadius: 1,color: Colors.grey.withAlpha(20))
        ]
      ) );
    var fillView = Flexible(child: Container(),);

    if(receivedMsg){
      var rowView = Row(children: <Widget>[
        avatarContainer,
        txtcontainer,
        fillView
      ],
      crossAxisAlignment: CrossAxisAlignment.start); 
    return Container(child: rowView, margin: EdgeInsets.only(right: 10, top: 10),);
    }else{
      var rowView = Row(children: <Widget>[
        fillView,
        txtcontainer,
        avatarContainer

      ],
      crossAxisAlignment: CrossAxisAlignment.start,); 
    return Container(child: rowView, margin: EdgeInsets.only(left: 10, top: 10),);
    }
  }
}

// var richTxt = RichText(
//       text: TextSpan(
//         text: 'This is ',
//         style: TextStyle(color: Colors.black, fontSize: 18.0),
//         children: <TextSpan>[
//           TextSpan(
//             text: 'bold ',
//             style: TextStyle(fontWeight: FontWeight.bold, )
//           ),
//           TextSpan(
//               text: 'text. '
//           ),
//           TextSpan(
//               text: 'This is ',),
//           TextSpan(
//               text: 'larger ',
//               style:
//               TextStyle(fontSize: 22.0)),
//           TextSpan(
//               text: 'font size.',),
//           TextSpan(
//             text: 'This is ',),
//           TextSpan(
//               text: 'red ',
              
//               style:
//               TextStyle(color: Colors.red)),
//           TextSpan(
//             text: 'color.',),
//         ],
//       ));