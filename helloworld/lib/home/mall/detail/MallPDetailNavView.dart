
//MARK:导航栏 
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 
import 'package:share/share.dart';
import 'package:share_extend/share_extend.dart';

class MallPDetailNavBarView extends PreferredSize {

  int navAlpha = 0;

  MallPDetailNavBarView(this.navAlpha);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var fanhui = InkWell(child: Image.asset("images/mall/fanhui.png"),
    onTap: (){
      Navigator.of(context).pop();
    },);
    var fenxiang = InkWell(child: Image.asset("images/mall/fenxiang.png"),
    onTap: (){

      share();
      // Share.share('check out my website http://www.baidu.com');

    },);
    var genduo = Image.asset("images/mall/genduo.png");

    double statusBarHeight = MediaQuery.of(context).padding.top; 
    double navHeight = (statusBarHeight + 44);

   var navView = Container(
         color: Colors.white.withAlpha(this.navAlpha),
        //  color: Colors.orange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[ 
            Container(child: fanhui,margin: EdgeInsets.only(left: 12),),
            Expanded(
              child: Container(),
            ),
            
            Container(child: fenxiang, margin: EdgeInsets.only(right: 12),),
            Container(child: genduo, margin: EdgeInsets.only(right: 12),),
            

          ],
        ),
        height: navHeight,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: statusBarHeight),
      ); 
    return navView;
    //============
  }

  share() async {
    File f =
    await ImagePicker.pickImage(source: ImageSource.gallery);
ShareExtend.share(f.path, "image");
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}