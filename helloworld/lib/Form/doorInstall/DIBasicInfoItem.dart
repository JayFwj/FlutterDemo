import 'package:Flutter/Form/addrManage/AddrModel.dart';
import 'package:Flutter/r.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DIBasicInfoItem extends StatelessWidget{

  bool showBottomLine = true;
  String title;
  String hint;

  DIBasicInfoItem(this.title,this.hint,this.showBottomLine);

  @override
  Widget build(BuildContext context) {

    var titleLbl = Text(this.title, 
    style: TextStyle(fontSize: 14, color: Color(0xff666666)),);

    var titleValueLbl = Text(this.hint, 
    style: TextStyle(fontSize: 14, color: Color(0xffc9caca)),);

    var indicatorView = Image.asset(R.resourcesImagesHomeJiantouPng);

    var bottomLine = Container(color: Color(0xfff3f8f9),height: 1,);


    var view = Container(color: Colors.white,
    height:45 ,
    child: Column(children: <Widget>[
      Expanded(child: 
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
        Container(child: titleLbl, margin: EdgeInsets.only(left: 10),),
        Expanded(child:Container(),),
        Container(child: titleValueLbl, margin: EdgeInsets.only(right:7 ),),
        Container(child: indicatorView, margin: EdgeInsets.only(right:10 ),),
        
      ],)
      ,),
      this.showBottomLine ? bottomLine : Container()
    ],),
    );
    return view;
  }
}

//MARK:Title
class DIBasicTitleItem extends StatelessWidget{

  String title;
  DIBasicTitleItem(this.title);

  @override
  Widget build(BuildContext context) {

    var titleLbl = Text(this.title, 
    style: TextStyle(fontSize: 14, color: Color(0xff666666)),);

    return Container(child: titleLbl,
    height: 43,
    color: Color(0xfff3f8f9),
    padding: EdgeInsets.only(left: 10,top: 18),
    );
  }
}


//MARK:Addr
class DIBasicAddrItemView extends StatefulWidget{

  BasicAddressModel addrModel;
  DIBasicAddrItemView(this.addrModel);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DIBasicAddrItemViewState();
  }
}

class _DIBasicAddrItemViewState extends State<DIBasicAddrItemView>{
  @override
  Widget build(BuildContext context) {
   
   var titleValueLbl = Text("请填写联系人及服务地址", 
    style: TextStyle(fontSize: 14, color: Color(0xffc9caca)),);

    var exclamatoryMarkView = Image.asset(R.resourcesImagesFormGantanhaoPng);
    var indicatorView = Image.asset(R.resourcesImagesHomeJiantouPng);


    var emptyView = Container(color: Colors.white,
    height: 80,
    child: Row(children: <Widget>[
      Container(child:exclamatoryMarkView, margin: EdgeInsets.only(left: 95) ,),
      Container(child: titleValueLbl, margin: EdgeInsets.only(left: 5),),
      Expanded(child: Container(),),
      Container(child: indicatorView, margin: EdgeInsets.only(right: 10),)

    ],)
    ,);
    if(widget.addrModel == null){
      return emptyView;
    }else{
      return ListTile(title: Text(widget.addrModel.name + " " + widget.addrModel.phone,
      style: TextStyle(color: Color(0xff666666),fontSize: 14),),
      subtitle: Text(widget.addrModel.addr,
      style: TextStyle(color: Color(0xff999999),fontSize: 12)),
      trailing: indicatorView,
      );
    }
  }
}



//MARK:顶部类型视图
class DIBasicHeaderView extends StatelessWidget{
  String title;
  DIBasicHeaderView(this.title);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Image iconView = Image.asset(R.resourcesImagesFormShangmenweixiuPng,fit: BoxFit.fill,);
    Text txt = Text(this.title, style: TextStyle(color: Color(0xff666666), fontSize: 16, fontWeight: FontWeight.bold));

    return Container(
      height:160 ,
      child: Column(
        children: <Widget>[
          Container(child: 
            ClipRRect(child: iconView, 
            borderRadius:BorderRadius.all(Radius.circular(35)) ,)
          ,width: 75, height: 75,
          margin: EdgeInsets.only(top: 20),),

            Container(child: txt, margin: EdgeInsets.only(top: 15),)
        ],

      ),

    );
  }
}

