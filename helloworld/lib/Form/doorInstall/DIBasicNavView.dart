import 'package:Flutter/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
 
//MARK:导航栏
class DIBasicNavView extends PreferredSize {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   
    Text titleView = Text(
                "上门安装",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff333333),fontSize: 18),
              );
    var backIcon = InkWell(child: Image.asset(R.resourcesImagesFormZuojiantouPng),
    onTap: (){
      Navigator.pop(context);
    },);

    var navView = SafeArea( 
        top: true, 
        child: Container(
          alignment: FractionalOffset.center,
          child:Stack(children: <Widget>[
            Center(child: titleView),
            Positioned(child: 
            Container(child: backIcon, width: 44, height: kBottomNavigationBarHeight,),
            left: 0
            ,)
          ],) ,
          height: 80,
        ));

    final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final Brightness brightness = appBarTheme.brightness;
    final SystemUiOverlayStyle overlayStyle = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Material(
          color: appBarTheme.color,
          elevation: 0,
          // shape: widget.shape,
          child: Semantics(
            explicitChildNodes: true,
            child: navView,
          ),
        ),
      ),
    );

    //============
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}