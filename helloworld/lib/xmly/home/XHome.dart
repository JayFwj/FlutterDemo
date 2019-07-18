import 'dart:ui';

import 'package:Flutter/r.dart';
import 'package:Flutter/widgets/rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class XHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _XHomeState();
  }
}

class _XHomeState extends State<XHome> with TickerProviderStateMixin {

  AnimationController animationController;
  bool showFirst = false;
  Color animColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animColor = Colors.blue;
    animationController = AnimationController(duration: Duration(seconds: 2), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    SizeTransition transition = SizeTransition(
      axisAlignment: 0.0,
      child: 
    Container( color: Colors.orange,height: 100,),
    sizeFactor: CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInCirc
    ),
    );  

    animationController.forward(); 
    var first = Container( height: 100,color: Colors.blue,);

    var second = Container(  height: 150,color: Colors.pink,);
    //两个视图交换
    AnimatedCrossFade crossFade = AnimatedCrossFade(
      firstCurve: Curves.easeIn, 
      secondCurve: Curves.easeInOut,
      firstChild:first,
       secondChild: second, 
       duration: Duration(milliseconds: 200),
    crossFadeState: showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
    );

    //高斯模糊
    var filter = ClipRect(
        child: BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: new Container( 
                color: Colors.white.withOpacity(0.1), 
                width: MediaQuery.of(context).size.width,
                height: 200,
                alignment: Alignment.center,
              ),
            ),
    ) ; 

    return Scaffold(
      appBar: AppBar(title: Text("首页"),),
      body: 
      // filterStack
      Container(color: Colors.white,
      child:
      Stack(children: <Widget>[
           ListView(
        children: <Widget>[
            Image.asset(R.resourcesImagesLakeJpg),
            crossFade,

            RatingBar(5),

            AnimatedContainer(
              child: Container(color: animColor, height: 120,),
              duration: Duration(seconds: 3),
              curve: Curves.easeIn,
               decoration: BoxDecoration(
              color: animColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ) 
            ), 
        ],
      ),
      filter
      ],)
      )
      , 

      floatingActionButton: InkWell(child: 
      Container(width: 50, height: 50, color: Colors.orange,)
      ,onTap: (){
          setState(() {
            showFirst = !showFirst;
            animColor = Colors.pink;
          });
      },),


    );
  }
}