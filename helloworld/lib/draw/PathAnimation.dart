import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class _Point {
  const _Point({this.x, this.y});
  final double x;
  final double y;
}

class _BezierTween extends Animatable<_Point> {
  _BezierTween({this.p0, this.p1, this.p2})
      : assert(p0 != null),
        assert(p1 != null),
        assert(p2 != null);
  final _Point p0; //起始点
  final _Point p1; //途径点
  final _Point p2; //终点
  @override
  transform(double t) {
    double x = (1 - t) * (1 - t) * p0.x + 2 * t * (1 - t) * p1.x + t * t * p2.x;
    double y = (1 - t) * (1 - t) * p0.y + 2 * t * (1 - t) * p1.y + t * t * p2.y;
    return _Point(x: x, y: y);
  }
}

class PathAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PathAnimationState();
  }
}

class _PathAnimationState extends State<PathAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  _Point _p0;
  _Point _p1;
  _Point _p2;

  List<_Point> points = List<_Point>();

  Animation<_Point> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _p0 = _Point(x: 30, y: 30);
    _p1 = _Point(x: 30, y: 200);
    _p2 = _Point(x: 200, y: 200);
    _animation = _BezierTween(p0: _p0, p1: _p1, p2: _p2).animate(_controller);

    _animation.addListener(() {
      this.setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
  
    points.add(_animation.value);
    
    List<Widget> childrens = List<Widget>();
    for (var item in points) { 
        childrens.add(
            Positioned(child: Container(color: Colors.orange, width: 3, height: 3,),
          top: item.x,
          left: item.y
        ,) );
    }

    childrens.add(Positioned(child: Container(color: Colors.orange, width: 20, height: 20,),
          top: _animation.value.x,
          left: _animation.value.y
        ,));

    return Scaffold(appBar: AppBar(title: Text("路径动画"),),
    body: Container(
        child: Stack(children: childrens,),
    color: Colors.white,
    ),
    floatingActionButton: InkWell(child: Container(child: Text("Go", textAlign: TextAlign.center,), color: Colors.orange, width: 44,height: 44,),onTap: (){
      
      if(_controller.isCompleted){
        _controller.reverse();
      }else{
        _controller.forward();
      }

    },),
    );
  }
}
