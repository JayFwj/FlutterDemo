import 'package:flutter/material.dart';

class CustomPopupRoute extends PopupRoute{
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;
 
  CustomPopupRoute({@required this.child});
 
  @override
  Color get barrierColor => null;
 
  @override
  bool get barrierDismissible => true;
 
  @override
  String get barrierLabel => null;
 
  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return child;
  }
 
  @override
  Duration get transitionDuration => _duration;
 
}

class PopupView extends StatelessWidget{

  final Widget child;
  final Function onClick; //点击child事件
  final double left; //距离左边位置
  final double top; //距离上面位置
 
  PopupView({
    @required this.child,
    this.onClick,
    this.left,
    this.top,
  });
 
  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.transparent, child: GestureDetector(child: Stack(
      children: <Widget>[
        Container(width: MediaQuery.of(context).size.width, 
        height: MediaQuery.of(context).size.height, 
        color: Colors.black.withAlpha(100),),
        Positioned(child: GestureDetector(child: child, onTap: (){ //点击子child
          if(onClick != null){ 
            Navigator.of(context).pop();
            onClick();
          }
        }),
        left: left,
        top: top,),
      ],
    ),
      onTap: (){ //点击空白处
        Navigator.of(context).pop();
      },
    ),);
  }
 
}