import 'package:Flutter/API/HKAPI.dart';
import 'package:Flutter/API/Home/HomeModel.dart';
import 'package:Flutter/API/mall/MallDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MallHeadView extends StatefulWidget {
  MallDataModel brandModel;
  int selectedIndex = 0;
  int subselectedIndex = 0; 

  MallHeadView(this.brandModel,this.selectedIndex, this.subselectedIndex);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MallHeadViewState();
  }
}

class _MallHeadViewState extends State<MallHeadView> {
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
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
      margin: EdgeInsets.only(top: 30),
      //  padding: EdgeInsets.all(10),
    );

    var brandNameLbl = Container(
      child: Text(
        widget.brandModel.brandName,
        style: TextStyle(fontSize: 18, color: Color(0xff333333)),
      ),
      margin: EdgeInsets.only(top: 15),
    );

    return Container(
      // height: 210,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          logoView,
          brandNameLbl,
          Container(
            child: MallHeadMenuView(widget.selectedIndex,widget.subselectedIndex, widget.brandModel.rpc),
            margin: EdgeInsets.only(top: 30),
          )
        ],
      ),
    );
  }
}

enum MallHeaderMenuEvenType{
  menu,submenu
}

class MallHeaderMenuEvenModel{
  MallHeaderMenuEvenType type;
  int selectedIndex;

  String cateID;
  String subcateID;

  MallHeaderMenuEvenModel(this.type, this.selectedIndex,{this.cateID, this.subcateID});
}

class MallHeadMenuView extends StatefulWidget {
  static EventBus eventBus = EventBus();
  int selectedIndex = 0;
  int subselectedIndex = 0;
  List<MallDataRpcModel> menus = List<MallDataRpcModel>();

  MallHeadMenuView(this.selectedIndex, this.subselectedIndex, this.menus);
 
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MallHeadMenuViewState();
  }
}

class _MallHeadMenuViewState extends State<MallHeadMenuView> {
  
  List<MallDataRpcModel> submenus = List<MallDataRpcModel>();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // menus.add("官网商场");
    // menus.add("普通商品");
    // menus.add("服务次卡");
    // menus.add("延保卡");
    // menus.add("空调");

    setStaicDynamicData();

    MallHeadMenuView.eventBus.on<MallHeaderMenuEvenModel>().listen((data){
         if(this.mounted == false ){
          return;
        }
        if(data.type == MallHeaderMenuEvenType.menu){
          this.widget.selectedIndex = data.selectedIndex;
          this.widget.subselectedIndex = 0;
          setStaicDynamicData();
        }else{
          this.widget.subselectedIndex = data.selectedIndex;
          setState(() {});
        }
    });
    
  }

  Future<void>loadSubmenu() async{
    if(this.mounted == false){
      return;
    }
    if(widget.selectedIndex == 0){
      submenus = [];
      return;
    }
    
     this.submenus = await HKAPI.shaderInstance.mallSubmenut(widget.menus[widget.selectedIndex].id);
    setState(() {});
  }

  setStaicDynamicData(){

    loadSubmenu();

    // submenus = List<String>();
    // if(this.widget.selectedIndex == 1){
    //   submenus.add("衣服");
    // submenus.add("鞋子");
    // submenus.add("帽子");
    // submenus.add("皮带");
    // submenus.add("女装");
    
    // }else if(this.widget.selectedIndex == 2){
    //   submenus.add("汽车清洗次卡");
    // submenus.add("空调清洗次卡");
    // submenus.add("汽车清洗次卡2");
    // submenus.add("空调清洗次卡2");
    // }else{
    //    submenus.add("冰箱111");
    // submenus.add("洗衣机22");
    // submenus.add("电视机33");
    // submenus.add("电脑44");
    // submenus.add("空调55");
    // }
  }

  @override
  Widget build(BuildContext context) {
    var firstMenuRow = ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:widget.menus.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: this.cateMenuItem(widget.menus[index].name, index == this.widget.selectedIndex),
            onTap: () { 
              MallHeadMenuView.eventBus.fire(MallHeaderMenuEvenModel(MallHeaderMenuEvenType.menu, index,cateID: widget.menus[index].id));
            
            },
          );
        });

    var divideLineView = Container(
      color: Colors.grey.withAlpha(40),
      height: 1,
    );

    if (this.widget.selectedIndex == 0) {
      return Column(
        
        children: <Widget>[
          divideLineView,
          Container(
            height: 45,
            color: Colors.white,
            child: firstMenuRow,
          ),
          //Container(color: Colors.grey, height: 1,),
        ],
      );
    } else {
      var secondMenuRow = ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: submenus.length,
          itemBuilder: (context, index) {
            return InkWell(
              child: this
                  .subcateMenuItem(submenus[index].name, index == this.widget.subselectedIndex),
              onTap: () {
                // subselectedIndex = index;
                MallHeadMenuView.eventBus.fire(MallHeaderMenuEvenModel(MallHeaderMenuEvenType.submenu, index, cateID: widget.menus[widget.selectedIndex].id, subcateID: submenus[index].id));
                // setState(() {});
              },
            );
          });

      return Column(
        children: <Widget>[
          divideLineView,
          Container(  
            height: 45,
            color: Colors.white,
            child: firstMenuRow,
           // margin: EdgeInsets.only(left: 10, right: 10),
          ),
          Container(
            height: 55,
            color: Color(0xfff3faf8),
            child: secondMenuRow,
            padding: EdgeInsets.only(left: 10, right: 10),
          ),
        ],
      );
    }
  }

  Widget cateMenuItem(String name, bool selected) {
    var selectedColor = Color(0xff139ef6); 

    return Container(child: Stack(
      children: <Widget>[  
        Container(
          height: 44,
          child: Align(
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 15,
                  color: selected ? selectedColor : Color(0xff333333)),
            ),
            alignment: FractionalOffset.center,
          ), 
        ), 
        Positioned(
          child: Container(
              height: 1, color: selected ? selectedColor : Colors.white),
          left: 0,
          right: 0,
          bottom: 0,
        ),
      ],
    ),
    margin: EdgeInsets.only(left: 15, right: 15),);
  }

  Widget subcateMenuItem(String name, bool selected) {
    var selectedColor = Color(0xff139ef6);
    var normalColor = Color(0xff666666);
    var normalBorderColor = Colors.grey.withAlpha(50);
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      child: Align(
        child: Container(
          height: 25,
          padding: EdgeInsets.only(left: 14, right: 14, top: 3),
          decoration: BoxDecoration(
              border: Border.all(
                  color: selected ? selectedColor : normalBorderColor,
                  width: 1),
              borderRadius: BorderRadius.all(Radius.circular(12.5))),
          child: Text(
            name,
            style: TextStyle(
                fontSize: 12, color: selected ? selectedColor : normalColor),
          ),
        ),
        alignment: FractionalOffset.center,
      ),
    );
  }
}
