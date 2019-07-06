import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../MallProductItem.dart';
import 'MallPDBottomView.dart';
import 'MallPDChooseSpecView.dart';

class MallProductDetail extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MallProductDetailState();
  }
}

class _MallProductDetailState extends State<MallProductDetail>{

  PageController pageController = PageController();

  bool showSpec = false;

  @override
  Widget build(BuildContext context) {

    // pageController.addListener((){
      // print("offset==>" + pageController.offset.toString());
    // });

    var pageView = PageView.builder(itemCount: 2,
    controller: pageController,
    itemBuilder: (context, index){

        if(index == 0){
          return MallPDBodyView();
        }else{
              return Container(color: Colors.orange ,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        );
        } 
    },
    scrollDirection: Axis.vertical,
    );

    MallProductItemData tempModel = MallProductItemData("https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=77d1cd475d43fbf2da2ca023807fca1e/9825bc315c6034a8ef5250cec5134954082376c9.jpg",
     "美的智能洗衣机", "全新款智能家居搭载5G网络与麒麟芯片，让生活更加智慧", 99);

    return Scaffold(appBar: AppBar(title: Text("商品详情"),),
    body:
      Stack(children: <Widget>[
        Positioned(child: pageView , bottom: 45,top: 0,left: 0, right: 0,),
        Positioned(child: 
         MallPDBottomView(addCartShowSpecAction, buyNowAction),
          bottom: 0, left: 0, right: 0,),
        showSpec ?   
        MallPDChooseSpecView(dismisSpec,tempModel, addCartAction,buyNowAction) : Container(),
      ],),
    // bottomNavigationBar: MallPDBottomView(),
    // floatingActionButton: FlatButton(child: Text("<->"), onPressed: (){
    //   pageController.previousPage(duration: Duration(milliseconds: 200),curve: Curves.ease);
    // },),
    );
  }

  addCartShowSpecAction(){
    showSpec = true;
    setState(() {
      
    });
  }

  addCartAction(){
    dismisSpec();
  }

  dismisSpec(){
    showSpec = false;
    setState(() {
      
    });
  }

  buyNowAction(){

  }
}