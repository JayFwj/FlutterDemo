import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MallProductItemData{
    String img; 
    String productName;
    String specification;
    double price;
    MallProductItemData(this.img, this.productName, this.specification, this.price);
}

class MallProductItem extends StatelessWidget{

  MallProductItemData itemModel;

  MallProductItem(this.itemModel);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     var productImgView = Container(
      child: CachedNetworkImage(
        imageUrl: itemModel.img,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
      ),
       height: 165,
      //  padding: EdgeInsets.all(10),
    );
    
    Text pnameView = Text(itemModel.productName, style: TextStyle(color: Color(0xff333333), fontSize: 12),);
    Text specNameView = Text(itemModel.specification, style: TextStyle(color: Color(0xff999999), fontSize: 12),);
    Text priceView = Text("¥" + itemModel.price.toString(), style: TextStyle(color: Color(0xffff4f62), fontSize: 15),);
    Container divideLineView = Container(color: Color(0xffefefef),height: 1, margin: EdgeInsets.only(left: 5 , right: 5),);
    Column column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Expanded(child: productImgView,),
      divideLineView,
      Container(child: pnameView,margin: EdgeInsets.only(top: 10, left: 10),),
      Container(child: specNameView,margin: EdgeInsets.only(top: 4, left: 10),),
      Container(child: priceView,margin: EdgeInsets.only(top: 10, bottom: 10, left: 10),),
      
    ],);

    return Container(  
    color: Colors.white, 
    child: column,
    //margin: EdgeInsets.only( top: 5, bottom: 5)
    );
  }
}