import 'package:Flutter/r.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'ShoppingCartItem.dart';

enum ShoppintCartEvenType{selectedAll, updatePrice, caculate}

class ShopCartEventModel{
  ShoppintCartEvenType type;
  bool selectedAllStatus;
  double totalPrice = 0.0;

  ShopCartEventModel(this.type,{ this.selectedAllStatus, this.totalPrice});
}

class ShoppingCartVC extends StatefulWidget {
  static EventBus eventBus = EventBus();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShoppingCartVCState();
  }
}

class _ShoppingCartVCState extends State<ShoppingCartVC> {
  List<ShoppingCartItemModel> list = List<ShoppingCartItemModel>();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list = ShoppingCartItemModel.dataList();

    ShoppingCartVC.eventBus.on<ShopCartEventModel>().listen((obj){
      if(obj.type == ShoppintCartEvenType.caculate){
          double totalPrice = ShoppingCartItemModel.caculateTotalPrice(list);
          ShoppingCartVC.eventBus.fire(ShopCartEventModel(ShoppintCartEvenType.updatePrice,totalPrice: totalPrice));
      }else if(obj.type == ShoppintCartEvenType.selectedAll){
          for(var item in list){
            item.selected = obj.selectedAllStatus;
          }
          ShoppingCartVC.eventBus.fire(ShopCartEventModel(ShoppintCartEvenType.caculate));
      }
    });


  }
  @override
  Widget build(BuildContext context) {
    var listView = ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: ShoppingCartItem(list[index]),
          onTap: () {
            //Navigator.pushNamed(context, "/SocketVC");
          },
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("购物车"),
      ),
      body: listView,
      bottomNavigationBar: ShoppingCartBottomView(ShoppingCartItemModel.caculateTotalPrice(list)),
    );
  }
}

//Mark:底部视图
class ShoppingCartBottomView extends StatefulWidget {
  double totalPrice = 0.0;

  ShoppingCartBottomView(this.totalPrice);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShoppingCartBottomViewState();
  }
}

class _ShoppingCartBottomViewState extends State<ShoppingCartBottomView> {
  bool selected = true;
  
  @override
  void initState() {
    super.initState();
    ShoppingCartVC.eventBus.on<ShopCartEventModel>().listen((data){
      if(data.type == ShoppintCartEvenType.updatePrice){
         widget.totalPrice = data.totalPrice;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    InkWell allBtn = InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: Row(
          children: <Widget>[
            Image.asset(
              selected
                  ? R.resourcesImagesCartLansegouxuanPng
                  : R.resourcesImagesCartGouxuankuangPng,
              width: 25,
              height: 22,
            ),
            Container(
              child: Text(
                "全选",
                style: TextStyle(fontSize: 12, color: Colors.black),
              ),
              margin: EdgeInsets.only(left: 4),
            )
          ],
        ),
      ),
      onTap: () {
        setState(() {
          selected = !selected;
        });
        ShoppingCartVC.eventBus.fire(ShopCartEventModel(ShoppintCartEvenType.selectedAll, selectedAllStatus: selected));
      },
    );
    var totalTitlelbl = Container(child: Text(
      "合计：",
      style: TextStyle(fontSize: 12, color: Colors.black),
    ),margin: EdgeInsets.only(left: 8));
    Text totalvaluelbl = Text(
      "¥ "+widget.totalPrice.toString(),
      style: TextStyle(fontSize: 14, color: Colors.red),
    );
    InkWell payBtn = InkWell(
      child: Container(
        child: 
        Align(child: Text("去结算", style: TextStyle(color: Colors.white)), 
              alignment: FractionalOffset.center,),
        color: Colors.red,
        width: 120,
        height: 44,
      ),
    );

    return Container(
      height: 44,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey,
            height: 0.5,
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                allBtn,
                totalTitlelbl,
                Expanded(
                  child: totalvaluelbl,
                ),
                payBtn,
              ],
            ),
          )
        ],
      ),
    );
  }
}
