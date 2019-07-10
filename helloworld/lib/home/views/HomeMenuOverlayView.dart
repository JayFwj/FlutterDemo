import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeMenuOverlayView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeMenuOverlayViewState();
  }
}

class _HomeMenuOverlayViewState extends State<HomeMenuOverlayView> with SingleTickerProviderStateMixin{
  GlobalKey shotKey = GlobalKey();
  RepaintBoundary repaintBoundary;

  bool expanded = false;
  Uint8List menuImageData;

  AnimationController animController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = expanded ? 100 : 44;
    double height = expanded ? 168 : 44;
    double itemHeight = 36;

    var menuView = Container(
      decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(14), topLeft: Radius.circular(14))),
      padding: EdgeInsets.only(top: 12, left: 5, bottom: 12),
      child: Column(
        children: <Widget>[
          HomeMenuItemView("images/home/diannao.png", "录声音", itemHeight,0,this.dismissCallback),
          HomeMenuItemView("images/home/jiaju.png", "移动", itemHeight,1,this.dismissCallback),
          HomeMenuItemView("images/home/shouji.png", "绘制", itemHeight,2,this.dismissCallback),
          HomeMenuItemView("images/home/shuma.png", "路径动画", itemHeight,3,this.dismissCallback),
        ],
      ),
    );

    repaintBoundary = RepaintBoundary(key: shotKey, child: menuView);

     
    var menuViewFold = Container(
      child: menuImageData != null ? Image.memory(menuImageData) : Container(),
      decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(22), topLeft: Radius.circular(22))),
      width: width,
      height: height,
    );
 
    var container = InkWell(
      child: AnimatedContainer(
        // constraints: BoxConstraints(maxHeight: 168, maxWidth: 100),
        child: expanded ? repaintBoundary : menuViewFold,
        width: width,
        height: height,
        duration: Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn, //easeInOutCirc easeInOutBack bounceIn
      ),
      onTap: () {
        expanded = !expanded;
        setState(() {});
      },
    );

    if(menuImageData == null){
      Timer(Duration(milliseconds: 400), (){
          takeScreenShot();
      });
    }else{
      Timer(Duration(milliseconds: 120), (){
        menuImageData = null;
          setState(() { 
          });
      });
    }

    return container;
  } 

  dismissCallback(){
    expanded = false;
    setState(() {
      
    });
  }

  takeScreenShot() async{ 
    RenderRepaintBoundary boundary  = shotKey.currentContext.findRenderObject();
    var image = await boundary.toImage(pixelRatio: 3.0);
    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
    menuImageData = byteData.buffer.asUint8List();
  }
}

class HomeMenuItemView extends StatelessWidget {
  String iconName;
  String name;
  double itemHeight;
  int id;
  VoidCallback dismissCallback;

  HomeMenuItemView(this.iconName, this.name, this.itemHeight, this.id, this.dismissCallback);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Image image = Image.asset(this.iconName);
    Text txt = Text(
      name,
      style: TextStyle(color: Color(0xffffffff), fontSize: 14),
    );

    return InkWell(child: Container(
      child: Row(
        children: <Widget>[
          Container(
            child: image,
            margin: EdgeInsets.only(left: 8),
          ),
          Container(
            child: txt,
            margin: EdgeInsets.only(left: 8),
          ),
        ],
      ),
      height: itemHeight,
    ),
    onTap: (){
      if(this.id == 0){
        Navigator.of(context).pushNamed("/RecordVC");
      }else if(this.id == 3){
        Navigator.of(context).pushNamed("/PathAnimation");
      }else if(this.id == 1){
        Navigator.of(context).pushNamed("/TouchMoveView");
      }else{
        Navigator.of(context).pushNamed("/DrawPractice");
      }

      this.dismissCallback();
    },
    );
  }
}
