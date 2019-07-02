import 'package:Flutter/API/Home/HomeModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MallHeadView extends StatefulWidget{

HomeBrandDataItem brandModel;

MallHeadView(this.brandModel);

@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MallHeadViewState();
  }
}

class _MallHeadViewState extends State<MallHeadView>{
  @override
  Widget build(BuildContext context) {
    
    var logoView = Container(
      child: ClipRRect(
        child: CachedNetworkImage(
        imageUrl: widget.brandModel.logo,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error), 
        fit: BoxFit.fill,
      ),
      borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      width: 60, height: 60,
      decoration: BoxDecoration(
        
      border: Border.all(color: Colors.grey.withAlpha(40), width: 1),
      borderRadius:BorderRadius.all(Radius.circular(4)) , 
      ),
      margin: EdgeInsets.only(top: 30),
      //  padding: EdgeInsets.all(10),
    );

    var brandNameLbl = Container(child: Text(widget.brandModel.brandName, style: TextStyle(fontSize: 18, color: Color(0xff333333)),),
      margin: EdgeInsets.only(top:15),
    );

    return Container(
      // height: 210,
      color: Colors.white,
      child: 
      Column(children: <Widget>[
          logoView,
          brandNameLbl,
          Container(child: MallHeadMenuView(), margin: EdgeInsets.only(top: 30),)
      ],)
    ,);
  }
}


class MallHeadMenuView extends StatefulWidget{

@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MallHeadMenuViewState();
  }
}

class _MallHeadMenuViewState extends State<MallHeadMenuView>{
  int selectedIndex = 0;
  int subselectedIndex = 0;

  List<String> menus = List<String>();

  List<String> submenus = List<String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menus.add("官网商场");
    menus.add("普通商品");
    menus.add("服务次卡");
    menus.add("延保卡");
    menus.add("空调");

    submenus.add("冰箱111");
    submenus.add("洗衣机22");
    submenus.add("电视机33");
    submenus.add("电脑44");
    submenus.add("空调55");
  }

  @override
  Widget build(BuildContext context) {
 
      var firstMenuRow = ListView.builder(scrollDirection: Axis.horizontal, 
      itemCount: menus.length, 
      itemBuilder: (context,index){
          return InkWell(child: this.cateMenuItem(menus[index], index == selectedIndex),
          onTap: (){
            selectedIndex = index;
            setState(() {});
          },
          );
      });

      var divideLineView = Container(color: Colors.grey.withAlpha(40), height: 1,);

    if(selectedIndex == 0){ 
       
      return Column(children: <Widget>[
        divideLineView,
        Container(height:45 ,color: Colors.white, 
          child:  firstMenuRow ,),
        //Container(color: Colors.grey, height: 1,),
      ],);

    }else{
      
      var secondMenuRow = ListView.builder(scrollDirection: Axis.horizontal, 
      itemCount: submenus.length, 
      itemBuilder: (context,index){
          return InkWell(child: this.subcateMenuItem(submenus[index], index == subselectedIndex),
          onTap: (){
            subselectedIndex = index;
            setState(() {});
          },
          );
      });

      return Column(
          children: <Widget>[
            divideLineView,

            Container(height:45 ,color: Colors.white, child: firstMenuRow ,margin: EdgeInsets.only(left: 10, right: 10),),

            Container(height:55 ,color: Color(0xfff3faf8), child: secondMenuRow  ,padding: EdgeInsets.only(left: 10, right: 10),),
          ],
      );
    } 
  }
  
  Widget cateMenuItem(String name, bool selected){
    var selectedColor = Color(0xff139ef6);
 
    return Container(
      height: 44,
      child: Column(children: <Widget>[
      Expanded(child: 
        Align(child: Text(name, style: TextStyle(fontSize: 15, color: selected ? selectedColor : Color(0xff333333)),), alignment: FractionalOffset.center,)
      ),

      Container(height: 2, color: selected ? selectedColor : Colors.orange,
      // width: 100
      ),
    ],),
    margin: EdgeInsets.only(left: 15,right: 15),
    );
  }

  Widget subcateMenuItem(String name, bool selected){
    var selectedColor = Color(0xff139ef6);
    var normalColor = Color(0xff666666);
    var normalBorderColor = Colors.grey.withAlpha(50);
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child:
      Align(child: 
        Container(
          height: 25,
          padding: EdgeInsets.only(left:14, right: 14, top: 3 ),
         decoration: 
         BoxDecoration(
           border: Border.all(color: selected ? selectedColor :normalBorderColor, width: 1),
           borderRadius: BorderRadius.all(Radius.circular(12.5))),

          child: Text(name, 
      style: TextStyle(fontSize: 12, color: selected ? selectedColor : normalColor),),
        )
      ,
      alignment:FractionalOffset.center,)
    ,);
  }

}




