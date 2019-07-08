import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../MallProductItem.dart';
import 'MallPDBottomView.dart';
import 'MallPDChooseSpecView.dart';
import 'MallPDetailNavView.dart';

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

  PageView pageView;
 

  int navAlpha = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 600), (){
      setStatusBarColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    setStatusBarColor();

    pageView = PageView.builder(itemCount: 2,
    physics: NeverScrollableScrollPhysics(),
    controller: pageController,
    itemBuilder: (context, index){
        if(index == 0){
          return MallPDBodyView(this.switchToSecondPage, this.firstPageScrollcallback);
        }else{
              return MallPDetailView(this.switchToSFirstPage);
        } 
    },
    scrollDirection: Axis.vertical,
    );

    MallProductItemData tempModel = MallProductItemData("https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=77d1cd475d43fbf2da2ca023807fca1e/9825bc315c6034a8ef5250cec5134954082376c9.jpg",
     "美的智能洗衣机", "全新款智能家居搭载5G网络与麒麟芯片，让生活更加智慧", 99);

    return Scaffold(
    body:
      Stack(children: <Widget>[
        Positioned(child: pageView , bottom: 45,top: -MediaQuery.of(context).padding.top,left: 0, right: 0,),
        Positioned(child: 
         MallPDBottomView(addCartShowSpecAction, buyNowAction),
          bottom: 0, left: 0, right: 0,),
        showSpec ?   
        MallPDChooseSpecView(dismisSpec,tempModel, addCartAction,buyNowAction) : Container(),

        Positioned(child: MallPDetailNavBarView(this.navAlpha),),
      ],),
    // bottomNavigationBar: MallPDBottomView(),
    // floatingActionButton: FlatButton(child: Text("<->"), onPressed: (){
    //   pageController.previousPage(duration: Duration(milliseconds: 200),curve: Curves.ease);
    // },),
    );
  }

  setStatusBarColor(){
    if(this.navAlpha < 100){
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    }else{
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }
  }
  
  //MARK:Actions
  switchToSecondPage(){
    pageController.jumpToPage(1);
  }

  switchToSFirstPage(){
    
    pageController.jumpToPage(0);
    this.navAlpha = 0;
    setState(() {});
  }

  firstPageScrollcallback(int alpha){
    this.navAlpha = alpha;
    setState(() {});
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

//MARK:商品详情视图
class MallPDetailView extends StatefulWidget{
  VoidCallback switchToSFirstPage;

MallPDetailView(this.switchToSFirstPage);

@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MallPDetailViewState();
  }
}

class _MallPDetailViewState extends State<MallPDetailView>{

  ScrollController secondPageController = ScrollController();
  bool switchToFirstPage = false;
  int hintAlpha = 0;
  String hintStr = "下拉回到\"商品详情\"";

  @override
  Widget build(BuildContext context) {
      secondPageController.addListener((){ 
    
      var offset = secondPageController.offset;
      var maxOffset = -40;
      int maxAlpha = 255; 
      hintStr = "下拉回到\"商品详情\"";

      if(offset < maxOffset){
        switchToFirstPage = true;
        hintAlpha = maxAlpha;
        hintStr = "释放回到\"商品详情\"";

      }else if(offset <= 0){   
        hintAlpha = (offset / maxOffset * maxAlpha).abs().toInt();
        switchToFirstPage = false;

      } else{
        hintAlpha = 0;
        switchToFirstPage = false;
      } 
      setState(() {});
    });

    Text txt = Text("使用3个引号可以定义多行字符串。字符串中加入”\n”也开始以换行。在字符串引号前边加上“r”，则不会转义。“+”进行多个字符串相加。“*n”将字符串复制n次。“==”用于判断两个字符串是否相等。“[n]”用于去除字符串中的第n个索引的子字符串");
    
    double statusBarHeight = MediaQuery.of(context).padding.top; 
    double navHeight = (statusBarHeight + 44);

    ListView listView = ListView(children: <Widget>[
      Container(child: txt,
       width:MediaQuery.of(context).size.width, 
       height: MediaQuery.of(context).size.height - 40,)

    ],controller: secondPageController,);

    Text hintText = Text(hintStr,textAlign: TextAlign.center, 
    style: TextStyle(fontSize: 14, color: Color(0xff333333).withAlpha(hintAlpha)),);

    Container hintView = Container( 
      margin: EdgeInsets.only(top: 20),
      color: Color(0xf3f7fa).withAlpha(hintAlpha),
    width: MediaQuery.of(context).size.width,
     height: 40,
    child: Align(child: hintText, alignment: FractionalOffset.center,) ,);

    Stack stack = Stack(children: <Widget>[
      listView,
      hintView
    ],);

    Container view = Container(child: stack, margin: EdgeInsets.only(top: navHeight),);

    return NotificationListener<ScrollUpdateNotification>(child: view, onNotification: (notification){
      var dragDetail = notification.dragDetails;
      if(dragDetail == null && switchToFirstPage == true){
          print("dragDetail = $dragDetail");
          switchToFirstPage = false;
          this.widget.switchToSFirstPage(); 
      }
      return false;
    }); 
     
  }
}