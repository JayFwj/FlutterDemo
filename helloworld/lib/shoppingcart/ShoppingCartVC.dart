import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'ShoppingCartItem.dart';

class ShoppingCartVC extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShoppingCartVCState();
  }
}

class _ShoppingCartVCState extends State<ShoppingCartVC>{

  List<ShoppingCartItemModel> list = List<ShoppingCartItemModel>(); 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    list.add(ShoppingCartItemModel(true, 1, "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1561978174696&di=9e25798607c413c33358a0699c614232&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fa71ea8d3fd1f41347fe08ef12b1f95cad0c85e6e.jpg",
     "美丽的裙子", "大码", 399));

     list.add(ShoppingCartItemModel(true, 1, "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1561978174695&di=157a753e8206ede1f21a5f673bc2ebf7&imgtype=0&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F32fa828ba61ea8d3fcd2e9ce9e0a304e241f5803.jpg",
     "暑期短袖", "小码", 88));
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

    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text("购物车"),),
      body:listView ,
    );
  }
}