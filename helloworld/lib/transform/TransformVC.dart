import 'dart:async';
import 'dart:math';

import 'package:Flutter/r.dart';
import 'package:Flutter/util/Util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// This is the type used by the popup menu below.
enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

class TransformVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TransformVCState();
  }
}

class _TransformVCState extends State<TransformVC> {
  int tranformDegress = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // var timer = Timer.periodic(Duration(milliseconds:100), (timer){
    //   tranformDegress += 5;
    //   setState(() {
        
    //   });
    // });
 
  }

  @override
  Widget build(BuildContext context) {
    Container view = Container(
      color: Colors.white,
      child: transformView(),
      margin: EdgeInsets.only(top: 50, left: 10, right: 10),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Transform"),
        actions: <Widget>[ 
            InkWell(child: Icon(Icons.plus_one),
            onTap: (){
      tranformDegress += 10;
          setState(() {});
            },
            )

        ],
      ),
      // body: view,
      body: TabbarDemoView(),

      floatingActionButton: FlatButton(
        child: Text("旋转"),
        onPressed: () {
          tranformDegress -= 10;
          setState(() {});
        },
      ),
    );
  }

  Widget transformView() {

    var colors = [
      Colors.grey,
    Colors.purple,
    Colors.pink,
    Colors.orange,
    Colors.blue,
    Colors.green,
    Colors.yellow
    ];

    List<TransItemView> clist = List<TransItemView>(); 

    int stepDeg = 360 ~/ colors.length; 

    for(int i=0;i<colors.length;i++){
      int deg =  (i * stepDeg + stepDeg + tranformDegress) % 360;
       if(deg == 0){
          deg = 360;
         clist.add(TransItemView(deg,  colors[i]));
      }
      else if(deg >= 300){
          clist.add(TransItemView(deg,  colors[i]));
      }
      else if(deg >= 240 && deg <= 300){
        if(clist.length>0){
          for(int j=0;j<clist.length;j++){
            var cur = clist[j];
            if(cur.rotateDegree < deg){
              clist.insert(j+1, TransItemView(deg,  colors[i])); 
              break;
            }
          }
    
        }else{
            clist.add(TransItemView(deg,  colors[i]));
        } 
      }else if(deg <= 90){
        clist.add(TransItemView(deg,  colors[i]));
      }
      else{
        clist.insert(0, TransItemView(deg,  colors[i]));
      }


    }
 
    Stack stack = Stack(
      children: 
      clist 
    );

    var container = Container(
      child: stack,
      width: 350,
      height: 400,
      margin: EdgeInsets.only(left: 0),
      color: Colors.transparent,
      alignment: Alignment.center,
    );
 
 
    return container;
  }

 
}


class TransItemView extends StatelessWidget{
  int rotateDegree;
   Color color;
   TransItemView(this.rotateDegree,this.color);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build{
   
   int deg =  rotateDegree;// (rotateDegree + tranformDegress) % 360;
   
    print("deg == $deg");
   var radian = Util.degreeToRadian(deg) ;

    var container = Container(

      color: color,
      child: ClipRRect(
        child: 
        Container(child: Text(deg.toString() + "-" + deg.toString()+"-"+deg.toString(),
        // textAlign: TextAlign.center,
        ),
        // margin: EdgeInsets.only(top: 40),
        )
        ,
        borderRadius: BorderRadius.all(Radius.circular(15),),
      ),
      width: 80,
      height: 150,
    ); 

    Matrix4 matrix4 = Matrix4.identity();
    matrix4.setEntry(3, 2, -0.001);
    matrix4.rotateX(Util.degreeToRadian(-10));
    matrix4.rotateY(radian);
    
    matrix4.translate(0.1,0.1, 
    90
    ); 
     
    var rotateTransform = Transform(
      alignment: FractionalOffset.center,
      transform:matrix4   
      ,child: container,
    );
    return rotateTransform;
     
    
  //   return Card(elevation: (rotateDegree.toDouble()-360).abs(), 
  //   color: Colors.transparent,
  //   child: rotateTransform,);
  // }
  //   return null;
  }
}

//MARK:Transform
class TransformDemoView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var view = Container(
      margin: EdgeInsets.only(top: 130, left: 30),
  color: Colors.black,
  child: 
  Transform(
    alignment: Alignment.topRight,
    transform: Matrix4.skewY(0.3)..rotateZ(-pi / 12.0),
    child: 
    Container(
      padding: const EdgeInsets.all(8.0),
      color: const Color(0xFFE8581C),
      child: const Text('Apartment for rent!'),
    ),
 ),
); 
    return view;
  }
}

//MARK:Transform

class TabbarDemoView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TabbarDemoViewState();
  }
}
class _TabbarDemoViewState extends State with SingleTickerProviderStateMixin{
  TabController controller;
  TabBar titles;
  String menuValue = "One";

  WhyFarther _selection;
  FocusNode focusNode = FocusNode();

  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(vsync: this, length: 3, initialIndex: 2)
     ..addListener(() {
          switch (controller.index) {
            case 0:
              print(1);
              break;
            case 1:
              print(2);
              break;
            case 2:
              print(3);
              break;
          }
      })
    ;

    editingController.addListener((){
        print("input=>>"+editingController.text);
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build 

    titles = TabBar(
      controller: this.controller,
      tabs: <Widget>[
          Text("水果"),
          Text("服装"),
          Text("电脑"), 
      ], 
    ); 
  
  var center = Center(
       child: DropdownButton<String>(
         value: "$menuValue",
         onChanged: (String newValue) {
           setState(() {
             this.menuValue = newValue;
           });
            print("newValue = $newValue");
         },
          items:
         <String>['One', 'Two', 'Free', 'Four']
           .map<DropdownMenuItem<String>>((String value) {
             return DropdownMenuItem<String>(
               value: value,
               child: Text(value),
             );
           })
           .toList(),
       ),
     );

   
// This menu button widget updates a _selection field (of type WhyFarther,
// not shown here).
PopupMenuButton popupMenuButton = PopupMenuButton<WhyFarther>(
  // offset: Offset(20, 100),
  
  itemBuilder: (BuildContext context) => <PopupMenuEntry<WhyFarther>>[
    const PopupMenuItem<WhyFarther>(
      value: WhyFarther.harder,
      child: Text('Working a lot harder'),
    ),
    const PopupMenuItem<WhyFarther>(
      value: WhyFarther.smarter,
      child: Text('Being a lot smarter'),
    ),
    const PopupMenuItem<WhyFarther>(
      value: WhyFarther.selfStarter,
      child: Text('Being a self-starter'),
    ),
    const PopupMenuItem<WhyFarther>(
      value: WhyFarther.tradingCharter,
      child: Text('Placed in charge of trading charter'),
    ),
  ],
);

// FocusScope.of(context).requestFocus(focusNode)
FlatButton dimissKeyboard = FlatButton(child: Text("Dismiss"),
  onPressed: (){
      focusNode.unfocus();
  },
);

AsyncSnapshot snapshot ;

EditableText editableText = EditableText(controller: editingController,
focusNode: focusNode,
minLines: 1,
maxLines: 5,
style: TextStyle(color: Colors.pink, fontSize: 16),
 cursorColor: Colors.orange,
  backgroundCursorColor: Colors.red,);
 
    var view = TabBarView(
      controller: controller,
      children: <Widget>[
          Container(color: Colors.orange,child: 
          ListView(children: <Widget>[
            Container(height: MediaQuery.of(context).size.height, child: WaveHeader(),),
            Container(height: 200, child: center,),
            Container(child: dimissKeyboard , height: 50, color: Colors.blue,),

            ClipRRect(child: 
            Container(color: Colors.black,
            // height: 90,
            constraints: BoxConstraints(maxHeight: 80),
            padding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
            child: editableText,),
           
            borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            
            
          ],)
          ,),
          Container(color: Colors.green,child: popupMenuButton,),
          Container(color: Colors.orange,child: 
          DecoratedBox(

  decoration:
   BoxDecoration(
    gradient: RadialGradient(
      center: const Alignment(-0.5, -0.6),
      radius: 0.15,
      colors: <Color>[
        const Color(0xFFEEEEEE),
        const Color(0xFF111133),
      ],
      stops: <double>[0.4, 1.0],
    ),
  ),
)
          ,),
      ],
    ); 

    return Column(children: <Widget>[
      Container(height: 50, child: titles,color: Colors.pink,),
      Expanded(child: view,),
    ],);
  }
}


//MARK:ClipPath


class WaveHeader extends StatefulWidget {
  @override
  WaveHeaderState createState() => new WaveHeaderState();
}

class WaveHeaderState extends State<WaveHeader> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: ClipPath(//剪切区域
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xff622F74),
                gradient: LinearGradient(//渐变色
                    colors: [Colors.blue, Colors.deepOrangeAccent],//  blue deepOrangeAccent
                    begin: Alignment.centerRight, //起点
                    end:  Alignment.topLeft //Alignment(-1.0, -1.0)
                    )),//终点
          ),
          Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: new BoxDecoration(
                          border: Border.all(color: Colors.amber, width: 2.0),
                          color: const Color(0xFFFFFFFF), // border color
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage(R.resourcesImagesLakeJpg))))),
            ],
          ),
        ],
      ),
      clipper: HeaderColor(),//主要部分
    ));
  }
}

class HeaderColor extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    //x坐标为0.0 y坐标为手机高度一半
    //到x坐标为手机宽度 到 手机宽度的一半减去100 达到斜线的结果
    //到x坐标为手机宽度 到 y坐标为手机宽度
    //完成
    var path = Path()
      ..lineTo(0.0, size.height / 2)
      ..lineTo(size.width, size.height / 2 - 180) 
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
