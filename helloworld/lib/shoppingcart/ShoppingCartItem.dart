import 'package:Flutter/plugin/stepper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sy_flutter_widgets/sy_flutter_widgets.dart';
import './ShoppingCartVC.dart';

class ShoppingCartItemModel{
  bool selected = false;
  int count;
  String img, name, specification;
  double price;
  ShoppingCartItemModel(this.selected, this.count, this.img, this.name, this.specification, this.price);

  static double caculateTotalPrice(List<ShoppingCartItemModel> list){
    double price = 0.0;
    for (var item in list) {
      if(item.selected){
        price += item.totalPrice();
      }
    }
    return price;
  }

  double totalPrice(){
    return (price * count);
  }

  static List<ShoppingCartItemModel> dataList(){

    List<ShoppingCartItemModel> list = new List<ShoppingCartItemModel>();
    list.add(ShoppingCartItemModel(true, 1, "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1561978174696&di=9e25798607c413c33358a0699c614232&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fa71ea8d3fd1f41347fe08ef12b1f95cad0c85e6e.jpg",
     "美丽的裙子", "大码", 399));

     list.add(ShoppingCartItemModel(true, 1, "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=062de105a36eddc439e7b2fb09d9b6a2/377adab44aed2e73830d49cc8901a18b86d6fa6e.jpg",
     "暑期短袖", "小码", 88));

     list.add(ShoppingCartItemModel(true, 1, "https://ss3.baidu.com/-fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=0ed135fcda2a28345ca6300b6bb4c92e/e61190ef76c6a7efa0938dc7f3faaf51f2de669d.jpg",
     "美丽的裙子1", "大码", 399));

     list.add(ShoppingCartItemModel(true, 1, "https://ss3.baidu.com/-fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=7eb5b3ce9bcad1c8cfbbfa274f3c67c4/83025aafa40f4bfbb5163db50d4f78f0f6361808.jpg",
     "暑期短袖aa", "小码", 88));

     list.add(ShoppingCartItemModel(true, 1, "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1561978174696&di=9e25798607c413c33358a0699c614232&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fa71ea8d3fd1f41347fe08ef12b1f95cad0c85e6e.jpg",
     "美丽的裙子ff", "大码", 399));

     list.add(ShoppingCartItemModel(true, 1, "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1965431379,4199093404&fm=26&gp=0.jpg",
     "暑期短袖gg", "小码", 88));

     list.add(ShoppingCartItemModel(true, 1, "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=812009488,2415501394&fm=26&gp=0.jpg",
     "美丽的裙子", "大码", 399));

     list.add(ShoppingCartItemModel(true, 1, "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=062de105a36eddc439e7b2fb09d9b6a2/377adab44aed2e73830d49cc8901a18b86d6fa6e.jpg",
     "暑期短袖ee", "小码", 88));

     list.add(ShoppingCartItemModel(true, 1, "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1561978174696&di=9e25798607c413c33358a0699c614232&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fa71ea8d3fd1f41347fe08ef12b1f95cad0c85e6e.jpg",
     "美丽的裙子dd", "大码", 399));

     list.add(ShoppingCartItemModel(true, 1, "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=062de105a36eddc439e7b2fb09d9b6a2/377adab44aed2e73830d49cc8901a18b86d6fa6e.jpg",
     "暑期短袖cc", "小码", 88));

     list.add(ShoppingCartItemModel(true, 1, "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1561978174696&di=9e25798607c413c33358a0699c614232&imgtype=0&src=http%3A%2F%2Fa.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fa71ea8d3fd1f41347fe08ef12b1f95cad0c85e6e.jpg",
     "美丽的裙子bb", "大码", 399));

     list.add(ShoppingCartItemModel(true, 1, "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=062de105a36eddc439e7b2fb09d9b6a2/377adab44aed2e73830d49cc8901a18b86d6fa6e.jpg",
     "暑期短袖aa", "小码", 88));

     list.add(ShoppingCartItemModel(true, 1, "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3353864496,464848093&fm=26&gp=0.jpg",
     "美丽的裙子11", "大码", 399));

     list.add(ShoppingCartItemModel(true, 1, "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2997402501,1990925726&fm=26&gp=0.jpg",
     "暑期短袖", "小码", 88));

     return list;
  }

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
  void initState() {
    // TODO: implement initState
    super.initState();
    ShoppingCartVC.eventBus.on<ShopCartEventModel>().listen((data){
      if(data.type == ShoppintCartEvenType.selectedAll){
        widget.itemModel.selected = data.selectedAllStatus;
        setState(() {});
      }
    }); 
  }

  @override
  Widget build(BuildContext context) {
    var chooseBtn = InkWell(child:  Image.asset( widget.itemModel.selected ? "images/cart/lansegouxuan.png" : "images/cart/gouxuankuang.png", width: 25,
      height: 22,),
      onTap: (){
        widget.itemModel.selected = !widget.itemModel.selected;
        ShoppingCartVC.eventBus.fire(ShopCartEventModel(ShoppintCartEvenType.caculate));
        setState(() {});
      },);

    var productImgView = Container(
      child: CachedNetworkImage(
        imageUrl: widget.itemModel.img,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
      ),
      width: 80, height: 80,
      margin: EdgeInsets.only(left: 10),
      //  padding: EdgeInsets.all(10),
    );
    
    Text pnameView = Text(widget.itemModel.name, style: TextStyle(color: Colors.black, fontSize: 16),);
    Text specNameView = Text(widget.itemModel.specification, style: TextStyle(color: Colors.grey, fontSize: 12),);
    Text priceView = Text(widget.itemModel.price.toString(), style: TextStyle(color: Colors.red, fontSize: 16),);
    SyStepper stepper = SyStepper(value: widget.itemModel.count, onChange: (count){
        widget.itemModel.count = count;
        ShoppingCartVC.eventBus.fire(ShopCartEventModel(ShoppintCartEvenType.caculate));
    },);
    Container stepperRow = Container(width: 100,height: 30,child: stepper,);
 
    return Container(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      height: 120,
      child: Row(children: <Widget>[
      Container(child: chooseBtn,width: 30, height: 30,
      // color: Colors.orange,
      margin: EdgeInsets.only(left: 10, right: 8),
      padding: EdgeInsets.zero,),
      Flexible(child: 
        Container(
            decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.grey.withAlpha(70)), color: Colors.grey.withAlpha(10),),
            margin: EdgeInsets.only(top: 5, bottom: 5, right: 10),
            child: Row(children: <Widget>[
              productImgView,
              Expanded(
                child: 
                Container( 
                  margin: EdgeInsets.only(left: 12),
                  child: 
                Stack(children: <Widget>[ 
                    Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  
                  Container(child: pnameView,margin: EdgeInsets.only(top: 12),),
                  Container(child: specNameView,margin: EdgeInsets.only(top: 4),),
                  Container(child: priceView,margin: EdgeInsets.only(top: 4),),
                ],),
                  Positioned(
                    child: stepperRow,
                    right: 10,
                    bottom: 14,
                   )
                ],) 
                ,)
              ,)

            ],),
        )
      ,)

    ],),);
  }
}

