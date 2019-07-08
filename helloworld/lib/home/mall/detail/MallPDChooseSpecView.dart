import 'dart:async';

import 'package:Flutter/home/mall/detail/MallPDBottomView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

import '../MallProductItem.dart';
import 'PDSpecView.dart';

class MallPDChooseSpecView extends StatefulWidget{

  VoidCallback dismissCallback;
  MallProductItemData itemModel;
  VoidCallback addCartCallback;
  VoidCallback buyNowCallback; 

  MallPDChooseSpecView(this.dismissCallback, this.itemModel, this.addCartCallback, this.buyNowCallback);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MallPDChooseSpecViewState();
  } 
}

class _MallPDChooseSpecViewState extends State<MallPDChooseSpecView>{
  bool visible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new Timer(Duration(milliseconds:50), (){
      visible = true;
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: <Widget>[
       Opacity(child:InkWell(child: Container(color: Colors.black,), onTap: (){widget.dismissCallback();},),  opacity: 0.2,),
      Positioned(child: bodyView(), bottom: 0, left: 0, right: 0,)
    ],),);
   
  }

  Widget bodyView(){

    var closeBtn = InkWell(child: Container(child: 
    Icon(Icons.close),
    margin: EdgeInsets.only(right: 15, top: 11),),onTap: (){
      widget.dismissCallback();
    },);

    //规格标签
    var specView = Container(child: Text("规格"),margin: EdgeInsets.only(left: 15, top: 30),);
    
    var specListView = PDSpecView();

    //数量标签
    var countView = Container(child: Text("数量"),margin: EdgeInsets.only(left: 15, top: 24,),);

    SyStepper stepper = SyStepper(value: 1, onChange: (count){
        
        
    },);
    Container stepperRow = Container(width: 100,height: 30,child: stepper,margin: EdgeInsets.only(right: 12),);

    var countRow = Row(children: <Widget>[Expanded(child: countView,), stepperRow],
    crossAxisAlignment: CrossAxisAlignment.center,);

    var emptyView = Container(color: Colors.white, height: 60,);

    var views = [
      Container(color: Colors.white, 
            child: Align(child: closeBtn, alignment: FractionalOffset.centerRight,),),
      productInfoView(context),
      specView,
      specListView,
      countRow, 
      emptyView,
    ]; 

    var listview = ListView(children: views,);

// AnimatedOpacity(
//           // If the widget is visible, animate to 0.0 (invisible).
//           // If the widget is hidden, animate to 1.0 (fully visible).
//           opacity: _visible ? 1.0 : 0.0,
//           duration: Duration(milliseconds: 500),
//           // The green box must be a child of the AnimatedOpacity widget.
//           child: Container(
//             width: 200.0,
//             height: 200.0,
//             color: Colors.green,
//           ), 

    return AnimatedOpacity(child: Container(color: Colors.white,
    constraints: BoxConstraints(maxHeight: 460),
    child: Stack(children: <Widget>[
        Positioned(child: listview, top: 0, left: 0, right: 0 , bottom: 45,),
        Positioned(child: MallPDBottomView(widget.addCartCallback, widget.buyNowCallback),left: 0, right: 0, bottom: 0,)
    ],),),duration: Duration(milliseconds: 300),opacity: visible ? 1.0 : 0.0,);
  }


  Widget productInfoView(BuildContext context)
  {
     var productImgView = Container(
      child: CachedNetworkImage( 
        imageUrl: widget.itemModel.img,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
      ),
       height: 90,
       width: 90,
       margin: EdgeInsets.only(left: 15),
      //  padding: EdgeInsets.all(10),
    );
    
    Text pnameView = Text(widget.itemModel.productName, 
    style: TextStyle(color: Color(0xff333333), fontSize: 14),);

    Text specNameView = Text(widget.itemModel.specification, 
    style: TextStyle(color: Color(0xff666666), fontSize: 12),
    softWrap: true,
    overflow: TextOverflow.ellipsis,);
    
    Text priceView = Text("¥" + widget.itemModel.price.toString(), 
    style: TextStyle(color: Color(0xffff4f62), fontSize: 16),);


    Column txtInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Container(child: pnameView,margin: EdgeInsets.only(top: 0,  ),),
      
      Container(width: MediaQuery.of(context).size.width - 135, child: specNameView,margin: EdgeInsets.only(top: 8,), 
      ),

      Container(child: priceView,margin: EdgeInsets.only(top: 12,),),
    ],);

    Row row = Row(children: <Widget>[
        productImgView,
        Container(child: txtInfo, margin: EdgeInsets.only(left: 15),)
    ],);
    return Container(color: Colors.white,height: 90,child: row,margin: EdgeInsets.only(top: 30),);
  }






  Widget dimisssView(){
    return Container(color: Colors.green);
  }
  //margin: EdgeInsets.only(bottom: 0, left: 0, right: 0)
}
