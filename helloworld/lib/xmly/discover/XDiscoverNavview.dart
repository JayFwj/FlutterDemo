import 'package:Flutter/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
 
//MARK:导航栏
class XDiscoverNavview extends PreferredSize {
  @override
  Widget build(BuildContext context) {
  
    var backIcon = InkWell(child: Image.asset(R.resourcesImagesFormZuojiantouPng),
    onTap: (){
      Navigator.pop(context);
    },);

    var navView = SafeArea( 
        top: true, 
        child: Container(
          color: Colors.white,
          alignment: FractionalOffset.center,
          child:Row(
            children: <Widget>[
              InkWell(child: Container(child: Icon(Icons.person_add),
              margin: EdgeInsets.only(left: 12),
              ),
              onTap: (){
                Navigator.of(context).pop();
              },),
              Expanded(child: Container(child: Center(child: Text("发现",style: TextStyle(fontSize: 18),),),),),
              Container(child: Icon(Icons.search),
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