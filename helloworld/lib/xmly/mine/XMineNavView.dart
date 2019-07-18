import 'package:Flutter/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
 
//MARK:导航栏
class XMineNavView extends PreferredSize {
  @override
  Widget build(BuildContext context) {
  
    var backIcon = InkWell(child: Image.asset(R.resourcesImagesFormZuojiantouPng),
    onTap: (){
      Navigator.pop(context);
    },);

    var navView = SafeArea( 
        top: true, 
        child: Container(
          color: Color(0xfffbf8f9),
          alignment: FractionalOffset.center,
          child:Row(
            children: <Widget>[
              InkWell(child: Container(child: Icon(Icons.email),
              margin: EdgeInsets.only(left: 12),
              ),
              onTap: (){
                Navigator.of(context).pop();
              },),
              Expanded(child: Container(),),
              Container(child: Icon(Icons.settings),
              margin: EdgeInsets.only(right: 12),
              ),
            ],
          ) ,
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