import 'package:flutter/material.dart';
import 'dart:math';

class TouchMoveView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TouchMoveState();
  }
}

class TouchMoveState extends State<TouchMoveView> {
  TouchMovePainter painter;
  //静止状态下的offset
  Offset idleOffset = Offset(0, 0);
  //本次移动的offset
  Offset moveOffset = Offset(0, 0);
  //最后一次down事件的offset
  Offset lastStartOffset = Offset(0, 0);

  @override
  void initState() {
    painter = TouchMovePainter();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var view = SizedBox(
      height: 44,
      width: 44,
      child: GestureDetector(
        onPanStart: (detail) {
          setState(() {
            lastStartOffset = detail.globalPosition;
            painter = TouchMovePainter();
            painter.painterColor = Colors.green;
          });
        },
        onPanUpdate: (detail) {
          setState(() {
            moveOffset = detail.globalPosition - lastStartOffset + idleOffset;
            moveOffset = Offset(max(0, moveOffset.dx), max(0, moveOffset.dy));
          });
        },
        onPanEnd: (detail) {
          setState(() {
            painter = TouchMovePainter();

            painter.painterColor = Colors.red;
            idleOffset = moveOffset * 1;
          });
        },
        child: CustomPaint(
          painter: painter,
          size: Size(10, 10),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text("拖动")),
      body: Container(
        decoration: BoxDecoration(
            gradient:
                // RadialGradient
                // (
                //   colors: [Color(0xFFFFFF00), Color(0xFF00FF00), Color(0xFF00FFFF)],
                // radius: 1,
                // tileMode: TileMode.mirror)
                LinearGradient
                (
                  begin: Alignment.topCenter,
                  // end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFFF00), Color(0xFF00FF00), Color(0xFF00FFFF)],
                tileMode: TileMode.mirror)

          //       SweepGradient(colors: [
          // Color(0xFFFFFF00),
          // Color(0xFF00FF00),
          // Color(0xFF00FFFF)
        // ], tileMode: TileMode.mirror)
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Transform.translate(offset: moveOffset, child: view)
          ],
        ),
      ),
    );
  }
}

class TouchMovePainter extends CustomPainter {
  var painter = Paint();
  var painterColor = Colors.red;

  @override
  void paint(Canvas canvas, Size size) {
    painter.color = painterColor;
    // canvas.drawCircle(Offset(size.width / 2, size.height / 2),
    //     min(size.height, size.width) / 2, painter);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2),
        min(size.height, size.width) / 2, painter);
  }

  @override
  bool shouldRepaint(TouchMovePainter oldDelegate) {
    return oldDelegate.painterColor != painterColor;
  }
}
