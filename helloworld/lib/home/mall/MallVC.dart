import 'package:Flutter/API/Home/HomeModel.dart';
import 'package:Flutter/home/mall/MallHeadView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:Flutter/shoppingcart/ShoppingCartItem.dart';

class MallVC extends StatefulWidget{

  HomeBrandDataItem brandModel;
  @override
  State<StatefulWidget> createState() {
    return _MallVCState();
  }
}

class _MallVCState extends State<MallVC>  {

  List<ShoppingCartItemModel> list = List<ShoppingCartItemModel>(); 
  ScrollController controller = ScrollController();
  bool showOverlay = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  }


  @override
  Widget build(BuildContext context) {

    this.widget.brandModel = ModalRoute.of(context).settings.arguments;

    controller.addListener((){
      // print("controller.offset = " + controller.offset.toString());
      if(controller.offset > 160){
        if(showOverlay == false){
          showOverlay = true;
           setState(() {
         });
        } 
      }else if(showOverlay){
        showOverlay = false;
        setState(() {});
      }
    });

    List<Widget> childers = List<Widget>();
    childers.add(MallHeadView(widget.brandModel));
    for (int i=0;i<list.length;i++) {
        childers.add(InkWell(
          child: ShoppingCartItem(list[i]),
          onTap: () {
            //Navigator.pushNamed(context, "/SocketVC");
          },
        ));
    }
 
    // var listView = GridView.count(crossAxisCount: 2, children: childers,);
     
     var listContainer = ListView(
        controller: controller,
        children: childers,);

    return Scaffold(appBar: AppBar(title: Text("官网商场"),elevation: 0),

      body:Stack(children: <Widget>[
        listContainer,
        showOverlay ? headOverlayMenuView() : Container()
      ],) ,
      bottomNavigationBar: bottomMenuView(),
    );
  }

  Widget headMenuView(){
    var container = Container(color: Colors.orange,height: 144,);

    return container;
  }

  Widget headOverlayMenuView(){
    return Positioned(child: MallHeadMenuView(), top: -1, left: 0, right: 0,);
  }

  Widget bottomMenuView(){
    var container = Container(color: Colors.orange,height: 44,);
    return container;
  }
}