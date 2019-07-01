import 'package:Flutter/plugin/stepper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';

class ShoppingCartItemModel{
  bool selected = false;
  int count;
  String img, name, specification;
  double price;
  ShoppingCartItemModel(this.selected, this.count, this.img, this.name, this.specification, this.price);
}

class ShoppingCartItem extends StatefulWidget{

  ShoppingCartItem(this.itemModel);

  ShoppingCartItemModel itemModel;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShoppingCartItemState();
  }
}

class _ShoppingCartItemState extends State<ShoppingCartItem>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    FlatButton chooseBtn = FlatButton(child: Icon(widget.itemModel.selected ? Icons.add : Icons.delete),
    onPressed: (){

    },);

    var productImgView = Container(
      child: CachedNetworkImage(
        imageUrl: widget.itemModel.img,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
      ),
      width: 50, height: 50,
      margin: EdgeInsets.all(10),
      //  padding: EdgeInsets.all(10),
    );
    
    Text pnameView = Text(widget.itemModel.name, style: TextStyle(color: Colors.black, fontSize: 16),);
    Text specNameView = Text(widget.itemModel.specification, style: TextStyle(color: Colors.grey, fontSize: 12),);
    Text priceView = Text(widget.itemModel.price.toString(), style: TextStyle(color: Colors.red, fontSize: 16),);
    SyStepper stepper = SyStepper(value: widget.itemModel.count, onChange: (count){
        widget.itemModel.count = count;
    },);
 
    return Container(
      height: 110,
      child: Row(children: <Widget>[
      Container(child: chooseBtn,width: 40, height: 40,margin: EdgeInsets.only(left: 12),),
      Flexible(child: 
        Container(
            child: Row(children: <Widget>[
              productImgView,
              Flexible(child: 
                Column(children: <Widget>[
                  pnameView,
                  specNameView,
                  priceView,
                  stepper
                ],)
              ,)

            ],),
        )
      ,)

    ],),);
  }
}

