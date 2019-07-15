import 'dart:ui';

import 'package:Flutter/util/Util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:flutter/material.dart';

enum DrawType {
  point,
  line,
  rect,
  rountrect,
  circle,
  arc,
  path,
  other,
  cubic,
}

class DrawPractice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DrawPracticeState();
  }
}

class _DrawPracticeState extends State<DrawPractice> {
  CustomPainter painter;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("绘制"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: SizedBox(
                  width: 500,
                  height: 300,
                  child: CustomPaint(
                    painter: this.painter,
                  ),
                ),
              ),
              rowItem("DrawLinePainter", () {
                setState(() {
                  this.painter = DrawLinePainter(DrawType.line);
                });
              }),
              rowItem("Rect", () {
                setState(() {
                  this.painter = DrawLinePainter(DrawType.rect);
                });
              }),
              rowItem("Circle", () {
                setState(() {
                  this.painter = DrawLinePainter(DrawType.circle);
                });
              }),
              rowItem("rountrect", () {
                setState(() {
                  this.painter = DrawLinePainter(DrawType.rountrect);
                });
              }),
              rowItem("other", () {
                setState(() {
                  this.painter = DrawLinePainter(DrawType.other);
                });
              }),
              rowItem("arc", () {
                setState(() {
                  this.painter = DrawLinePainter(DrawType.arc);
                });
              }),
              rowItem("path", () {
                setState(() {
                  this.painter = DrawLinePainter(DrawType.path);
                });
              }),
              rowItem("cubic", () {
                setState(() {
                  this.painter = DrawLinePainter(DrawType.cubic);
                });
              }),
            ],
          ),
        ),
        margin: EdgeInsets.only(top: 30),
      ),
    );
  }

  Widget rowItem(String title, VoidCallback callback) {
    return InkWell(
      child: Container(
        height: 44,
        padding: EdgeInsets.only(top: 10),
        child: Text(title),
        color: Colors.grey.withAlpha(70),
      ),
      onTap: () {
        callback();
      },
    );
  }
}

//MARK:Painter
class DrawLinePainter extends CustomPainter {
  DrawType drawType;

  DrawLinePainter(this.drawType);

  var _paint = Paint()
    ..color = Colors.black
    ..strokeCap = StrokeCap.square
    ..isAntiAlias = true
    ..style = PaintingStyle.fill
    ..strokeWidth = 5;

  @override
  void paint(Canvas canvas, Size size) {

    
    // TODO: implement paint
    switch (this.drawType) {
      case DrawType.line:
        drawLine(canvas, size);
        break;
      case DrawType.rect:
        drawRect(canvas, size);
        break;
      case DrawType.circle:
        drawCircle(canvas, size);
        break;
      case DrawType.rountrect:
        drawRRect(canvas, size);
        break;

      case DrawType.rountrect:
        drawRRect(canvas, size);
        break;

      case DrawType.other:
        drawOther(canvas, size);
        break;

      case DrawType.arc:
        drawARC(canvas, size);
        break;

      case DrawType.path:
        drawPath(canvas, size);
        break;

      case DrawType.cubic:
        drawCubic(canvas, size);
        break;

      default:
    }
  }

  void drawCubic(Canvas canvas, Size size) {
    drawAxix(canvas, size);

    _paint.style = PaintingStyle.stroke;
    _paint.strokeWidth = 2;

    var path = Path();
    path.moveTo(100.0, 100.0);

    /// Adds a cubic bezier segment that curves from the current point
    /// to the given point (x3,y3), using the control points (x1,y1) and
    /// (x2,y2).

    double controlY = 400;
    double controlX = 150;

    double control2Y = 0;
    double control2X = 250;

    double poiotY = 200;
    double point1X = 30;
    double point2X = 300;
    path.moveTo(point1X, poiotY);

    path.cubicTo(controlX, controlY, control2X, control2Y, point2X, poiotY);

    canvas.drawPath(path, _paint);
  }

  //画坐标系
  void drawAxix(Canvas canvas, Size size) {
    _paint.style = PaintingStyle.stroke;
    _paint.strokeWidth = 1;
    _paint.color = Colors.black;
    _paint.strokeJoin = StrokeJoin.round;

    double maxY = size.height - 10;
    double startX = 30;

    var path = Path();
    path.moveTo(startX, 10);
    path.lineTo(startX, maxY);
    path.lineTo(size.width - 10, size.height - 10);
    canvas.drawPath(path, _paint);

    //原点
    _paint.style = PaintingStyle.fill;
    _paint.color = Colors.black;
    _paint.strokeWidth = 5;
    canvas.drawCircle(Offset(startX, maxY), 3, _paint);

    //画刻度
    drawScale(canvas, size);
   
  }

  void drawScale(Canvas canvas, Size size) {
    var fontColor = Colors.grey;
    double fontSize = 12;

    List<ChatBean> chatBeans = [
      ChatBean(0),
      ChatBean(1),
      ChatBean(2),
      ChatBean(3),
      ChatBean(4),
      ChatBean(5),
      ChatBean(6),
      ChatBean(7),
      ChatBean(8),
    ];
    double startX = 30;
    double startY = size.height - 10;
    double basePaddingY = 8;

    double fixedWidth = size.width ; //- 35;
    double fixedHeight = size.height - 30;

    double rulerWidth = 3;

    int length = chatBeans.length > 10 ? 10 : chatBeans.length;  
    // double DW = fixedWidth / (length - 1); //两个点之间的x方向距离
    double DH = fixedWidth / (length - 1);  // fixedHeight / (length - 1); //两个点之间的y方向距离
    double DW = DH;
    for (int i = 0; i < length; i++) {
      ///绘制x轴文本
      TextPainter(
          textAlign: TextAlign.center,
          ellipsis: '.',
          text: TextSpan(
              text: chatBeans[i].x.toString(),
              style: TextStyle(color: fontColor, fontSize: fontSize)),
          textDirection: TextDirection.ltr)
        ..layout(minWidth: 40, maxWidth: 40)
        ..paint(canvas, Offset(startX + DW * i - 20, startY + basePaddingY));


      if(i > 0){
          _paint.color = Colors.black;
          //Y刻度值
          TextPainter(textAlign: TextAlign.center,
          ellipsis: ".",
          text: TextSpan(text: chatBeans[i].x.toString(),
          style: prefix0.TextStyle(color: fontColor, fontSize: fontSize)
          ),
          textDirection: TextDirection.ltr,
          )..layout(minWidth: 20, maxWidth: 20)
          ..paint(canvas, Offset(startX - 25 , startY - i * DH - 7));
          //X
          canvas.drawCircle(Offset(startX + DW * i, startY), rulerWidth, _paint);
          //Y
          canvas.drawCircle(Offset(startX , startY - i * DH), rulerWidth, _paint);

          //画网格线
          _paint.color = Colors.grey.withAlpha(100);
          _paint.strokeWidth = 1;
          canvas.drawLine(Offset(startX , startY - i * DH), 
          Offset(fixedWidth , startY - i * DH), _paint);

          double vx = startX + DW * i; 
          canvas.drawLine(Offset(vx, 20), 
          Offset(vx , startY), _paint);

      }  
      
    }
  }

  void drawPath(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(100.0, 100.0);
    path.lineTo(200, 250);
    path.lineTo(300, 280);
    path.lineTo(250, 100);

    canvas.drawShadow(path, Colors.black, 13, true);

    canvas.drawPath(path, _paint);
  }

  void drawARC(Canvas canvas, Size size) {
    var rect1 = Rect.fromCircle(center: Offset(100, 120), radius: 100);
    canvas.drawArc(rect1, 0, Util.degreeToRadian(-190), true, _paint);

    var rect2 = Rect.fromCircle(center: Offset(200, 100), radius: 80);
    canvas.drawArc(rect2, 0, Util.degreeToRadian(90), true, _paint);
  }

  void drawOther(Canvas canvas, Size size) {
    //需要先画大的，再画小的
    var rect1 = Rect.fromCircle(center: Offset(150, 150.0), radius: 70.0);
    var rect2 = Rect.fromCircle(center: Offset(150.0, 150.0), radius: 50.0);

    var rRect1 = RRect.fromRectAndRadius(rect1, Radius.circular(20.0));
    var rRect2 = RRect.fromRectAndRadius(rect2, Radius.circular(10.0));
    //画嵌套矩形
    canvas.drawDRRect(rRect1, rRect2, _paint);
  }

  void drawLine(Canvas canvas, Size size) {
    // TODO: implement paint
    canvas.drawLine(Offset(20, 20), Offset(300, 20), _paint);
  }

  void drawRect(Canvas canvas, Size size) {
    // TODO: implement paint
    canvas.drawRect(Rect.fromLTWH(50, 50, 100, 100), _paint);
  }

  void drawCircle(Canvas canvas, Size size) {
    // TODO: implement paint
    canvas.drawCircle(Offset(50, 50), 50, _paint);
  }

  void drawRRect(Canvas canvas, Size size) {
    // TODO: implement paint
    var rect = Rect.fromPoints(Offset(100.0, 100.0), Offset(250.0, 250.0));
    //把矩形转成圆角矩形
    var rRect = RRect.fromRectAndRadius(rect, Radius.circular(20.0));

    canvas.drawRRect(rRect, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class ChatBean {
  double x;
  ChatBean(this.x);
}
