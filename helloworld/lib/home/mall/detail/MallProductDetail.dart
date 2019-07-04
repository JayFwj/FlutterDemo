import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class MallProductDetail extends StatefulWidget {
  _LogoAppState createState() => new _LogoAppState();
}

class _LogoAppState extends State<MallProductDetail> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}


//
class MallProductDetail2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MallProductDetailState();
  }
}

class _MallProductDetailState extends State<MallProductDetail2>{

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {

    // pageController.addListener((){
      // print("offset==>" + pageController.offset.toString());
    // });

    var pageView = PageView.builder(itemCount: 3,
    controller: pageController,
    itemBuilder: (context, index){
        return Container(color: index == 1 ? Colors.orange : Colors.grey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        );
    },
    scrollDirection: Axis.vertical,
    );

    return Scaffold(appBar: AppBar(title: Text("商品详情"),),
    body: pageView,
    floatingActionButton: FlatButton(child: Text("<->"), onPressed: (){
      pageController.previousPage(duration: Duration(milliseconds: 200),curve: Curves.ease);
    },),
    );
  }
}