import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(appBar: AppBar(title: Text("商品详情"),),
    body:
      Stack(children: <Widget>[
        pageView,
        Positioned(child: 
         MallPDBottomView(addCartAction, buyNowAction),
          bottom: 0, left: 0, right: 0,),
        showSpec ?   
        MallPDChooseSpecView(dismisSpec) : Container(),
      ],),
    // bottomNavigationBar: MallPDBottomView(),
    floatingActionButton: FlatButton(child: Text("<->"), onPressed: (){
      pageController.previousPage(duration: Duration(milliseconds: 200),curve: Curves.ease);
    },),
    );
  }

  addCartAction(){
    showSpec = true;
    setState(() {
      
    });
  }

  dismisSpec(){
    showSpec = false;
    setState(() {
      
    });
  }

  buyNowAction(){

  }
}