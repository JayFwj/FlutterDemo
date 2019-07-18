import 'dart:math';

import 'package:Flutter/r.dart';
import 'package:Flutter/xmly/mine/XMine.dart';
import 'package:Flutter/xmly/mine/XMineNavView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'XDiscoverNavview.dart';

class XDiscover extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _XDiscoverStat();
  }
}

class _XDiscoverStat extends State<XDiscover>
    with SingleTickerProviderStateMixin {
  TabController controller;
  int selectedIndex = 0;

  var selectedColor = Colors.black;
  var normalColor = Color(0xffc0c0c0);

  double selectedFont = 18;
  double normalFont = 14;

  final LabeledGlobalKey attenKey = LabeledGlobalKey("atte");
  final GlobalKey recKey = LabeledGlobalKey("recKey");
  final GlobalKey addVoiceKey = LabeledGlobalKey("addVoiceKey");
  final GlobalKey circuleKey = LabeledGlobalKey("circuleKey");
  
  List<GlobalKey> keys;
  double bodyheight = 500;
  TabBarView tabbarView;

  PageController pageController = PageController();

  ScrollController outScrollController = ScrollController();
  ScrollController subScrollController = ScrollController();

  bool subListViewCanScroll = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    keys = [attenKey, recKey, addVoiceKey, circuleKey,];

    controller =
        TabController(vsync: this, length: 4, initialIndex: selectedIndex)
          ..addListener(() {
            
             selectedIndex = controller.index;
              pageController.animateToPage(selectedIndex,curve: Curves.ease, duration: Duration(milliseconds: 100));
            setState(() {
              // subListViewCanScroll = false;
            }); 
          });

    // outScrollController.addListener((){
    //   double offset = outScrollController.offset;

    //   print("outScrollController.offset = " + offset.toString()  );

    //   if(offset >= 137){
    //     if(subListViewCanScroll == false){
    //       setState(() {
    //         subListViewCanScroll = true;  
    //       });  
    //     }
    //   }else if(subListViewCanScroll){
    //       setState(() {
    //         subListViewCanScroll = false;  
    //       });  
    //     } 
    // });

    // subScrollController.addListener((){
    //   double offset = subScrollController.offset;
    //   double outoffset = outScrollController.offset;

    //   print("subScrollController.offset = " + offset.toString() + " outoffset = $outoffset");

    //   if(offset <= 0 || outoffset < 137 ){ 
    //     if(subListViewCanScroll == true){
    //       setState(() {
    //         subListViewCanScroll = false;  
    //       }); 
    //     } 
    //   } 
    // });

    
  }

  @override
  Widget build(BuildContext context) {
      
    PageView pageView = PageView.builder( 
      itemCount: 4,
      itemBuilder: (context, index){
          return childListView((index + 1) * 5, addVoiceKey);
      },
      controller: pageController,
      scrollDirection: Axis.horizontal,
      onPageChanged: (index){ 
        controller.animateTo(index,curve: Curves.ease, duration: Duration(milliseconds: 100));
      },
      // physics: NeverScrollableScrollPhysics(),
    );
  
     return Scaffold(
      appBar: XDiscoverNavview(),
      body: Container( 
        child: ListView(
          controller: outScrollController,
          children: <Widget>[
            headerView(),
            Container(
              height: 10,
              decoration: BoxDecoration(gradient: LinearGradient(
                colors: [Color(0xfff9f9f9),Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
              )),
            ),
            Container(height: 50, child: titlesView(),color: Colors.white,),

            Container(height: bodyheight, child: pageView,color: Colors.white,), ],
        ),
      ),
    ); 
  }

  Widget childListView(int count, GlobalKey key){
    ListView childListView = ListView.builder(
      controller: subScrollController,
      itemCount: count,
      shrinkWrap: true,
      physics: subListViewCanScroll ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.primaries[index % Colors.primaries.length],
          child: SizedBox(
            width: 100.0,
            height: 50.0 + ((27 * index) % 15) * 3.14,
            child: Center(
              child: Text('$index'),
            ),
          ),
        );
      },
    );
    return childListView;
  }
  Widget titlesView(){
  var titles = Container(child: TabBar(
      controller: this.controller,
      tabs: <Widget>[
        menuItem("关注", selectedIndex == 0),
        menuItem("推荐", selectedIndex == 1),
        menuItem("趣配音", selectedIndex == 2),
        menuItem("圈子", selectedIndex == 3),
      ],
    ),color: Colors.white,);
    return titles;
  }
  

  Widget headerView(){
    var headerview = Container(
      color: Colors.white,
      height: 112,
      padding: EdgeInsets.only(top: 20, left: 12, right: 18),
      child: GridView(
        children: <Widget>[
          XDiscoverMenuItem(XMineMenuModel(
              titleStr: "全民朗读",
              iconStr: R.resourcesXmlyHostSmallIconDefault1Png)),
          XDiscoverMenuItem(XMineMenuModel(
              titleStr: "K歌房",
              iconStr: R.resourcesXmlyHostSmallIconDefault2Png)),
          XDiscoverMenuItem(XMineMenuModel(
              titleStr: "喜马士拨鼠",
              iconStr: R.resourcesXmlyHostSmallIconDefault2Png)),
          XDiscoverMenuItem(XMineMenuModel(
              titleStr: "活动",
              iconStr: R.resourcesXmlyHostSmallIconDefault3Png)),
        ],
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 66.0,
            childAspectRatio: 1,
            crossAxisSpacing: 30),
      ),
    );
    return headerview;
  }

  Widget menuItem(String title, bool selected) {
    var txtView = Text(title,
        style: TextStyle(
            color: selected ? selectedColor : normalColor,
            fontSize: selected ? selectedFont : normalFont));

    if (selected) {
      var animView = AnimatedContainer(
        child: txtView,
        duration: Duration(seconds: 1),
        curve: Curves.ease,
      );
      return animView;
    } else {
      return txtView;
    }
  }
}

//MARK:Item
class XDiscoverMenuItem extends StatelessWidget {
  XMineMenuModel model;

  XDiscoverMenuItem(this.model);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 66,
      height: 66,
      // color: Colors.pink,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(this.model.iconStr),
            width: 34,
            height: 34,
          ),
          Container(
            child: Text(
              this.model.titleStr,
              style: TextStyle(fontSize: 12),
            ),
            margin: EdgeInsets.only(top: 6),
          )
        ],
      ),
    );
  }
} 