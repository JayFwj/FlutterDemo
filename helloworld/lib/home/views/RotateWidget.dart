
import 'dart:math';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  _SplashScreen createState() => new _SplashScreen();
}

class _SplashScreen extends State<StatefulWidget>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState(); 
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 3), 
    ); 
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context){
    return new Container(
      alignment: Alignment.center,
      color: Colors.white,

      child: new Stack(children: <Widget>[

        new AnimatedBuilder(
          animation: animationController,
          child :Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('images/lake.jpg'),fit: BoxFit.cover)),

          ),
          builder: (BuildContext context, Widget _widget) {
            return new Transform.rotate(
              angle: degree2Radian(animationController.value),
              child: _widget,
            );
          },
        ), 
      ],),
    );
  }
  double degree2Radian(double degree) {
    return ((degree * 360) * pi / 180); 
  }
}
