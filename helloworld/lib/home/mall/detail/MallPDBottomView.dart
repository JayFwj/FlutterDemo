import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MallPDBottomView extends StatelessWidget {

  VoidCallback addCartCallback;
  VoidCallback buyNowCallback; 

  MallPDBottomView(this.addCartCallback, this.buyNowCallback);

  @override
  Widget build(BuildContext context) {
    
    Container container = Container(
      color: Color(0xff139ef6),
      height: 45,
      child: Row(children: <Widget>[
        Expanded(child: InkWell(child: buttonItem("加入购物车",Color(0xffff596b)), onTap: (){
          addCartCallback();
        }
        ,),),
        Expanded(child: InkWell(child: buttonItem("立即购买", Color(0xff23a1f4)), onTap: (){
          buyNowCallback();
        },),) 
      ],),
    );

    return container; 
  }

  Widget buttonItem(String title, Color bgColor){
    return Container(
      color: bgColor,
      child: Align(child: Text(title, style: TextStyle(color: Colors.white),),),
    );
  }
}

class MallPDBodyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Column column = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        topView(),
        specificationView(),
        commentView(),
      ],
    );

    Container container = Container(
      color: Color(0xfff3f9f9),
      child: column,
    );

    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return container;
      },
    );
  }

  Widget topView() {
    List<String> images = [
      "https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=77d1cd475d43fbf2da2ca023807fca1e/9825bc315c6034a8ef5250cec5134954082376c9.jpg",
      "https://ss3.baidu.com/-fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=b5e4c905865494ee982209191df4e0e1/c2cec3fdfc03924590b2a9b58d94a4c27d1e2500.jpg",
      "https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=0c78105b888ba61ec0eece2f713597cc/0e2442a7d933c8956c0e8eeadb1373f08202002a.jpg",
    ];

    PageView pageView = PageView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Container(
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: images[index],
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                // width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            // color: Colors.green,
            margin: EdgeInsets.only(left: 5, right: 5),
            width: MediaQuery.of(context).size.width);
      },
    );

    var imageCountView = Opacity(child:
      ClipRRect(
              child: 
              Container(child: 
              Align(child: Text("1/"+images.length.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize:13 ),
              ),
              alignment: FractionalOffset.center,
              ),
              color: Colors.black,
              width: 40,
              height: 20,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )
    ,opacity: 0.5,);

    Container productImage = Container(
      color: Colors.grey,
      height: 375,
      child: Stack(children: <Widget>[
          pageView,
          Positioned(child: imageCountView, right:15, bottom: 15 ,)
      ],),
    );

    Text pname = Text(
      "美的洗衣机",
      style: TextStyle(
          fontSize: 15, color: Color(0xff333333), fontWeight: FontWeight.bold),
    );

    Text desc = Text(
      "智能化洗衣机，自动清洗",
      style: TextStyle(fontSize: 12, color: Color(0xff333333)),
    );

    Text price = Text("¥299.0",
        style: TextStyle(
            fontSize: 18,
            color: Color(0xffff596b),
            fontWeight: FontWeight.bold));

    return Container(
      color: Color(0xffffffff),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          productImage,
          Container(
            child: price,
            margin: EdgeInsets.only(left: 10, top: 18),
          ),
          Container(
            child: pname,
            margin: EdgeInsets.only(left: 10, top: 18),
          ),
          Container(
            child: desc,
            margin: EdgeInsets.only(left: 10, top: 10, bottom: 15),
          ),
        ],
      ),
    );
  }

  Widget specificationView() {
    return Container(
      color: Color(0xffffffff),
      margin: EdgeInsets.only(top: 10),
      height: 91,
      child: Column(
        children: <Widget>[
          specificationItemWidget("选择地域", "请选择地域"),
          Container(color: Colors.grey.withAlpha(50),height: 0.5,),
          specificationItemWidget("选择规格", "请选择规格"),
        ],

      ),
    );
  }

  Widget commentView() {   
    return Container(
      color: Color(0xffffffff),
      margin: EdgeInsets.only(top: 10),
      height: 223.5,
      child: Column(children: <Widget>[
        commentTitle(),
        CommentItemView(),
      ],),
    );
  }

  //MARK：评价Title
  Widget commentTitle(){
    Text titleLbl = Text(
      "服务产品评价",
      style: TextStyle(fontSize: 14, color: Color(0xff333333)),
    );

    Text subLbl = Text(
      "(共有1.2万条评价)",
      style: TextStyle(fontSize: 10, color: Color(0xff666666)),
    );

    Text readAllBtn = Text(
      "查看全部",
      style: TextStyle(fontSize: 14, color: Color(0xff139ff7)),
    );

    Image rightIndicatorView = Image.asset("images/mall/fapiaoyoujiantou.png");

    return Container(
      color: Color(0xffffffff),
      margin: EdgeInsets.only(top: 10),
      height: 40,
      child: Row(
        children: <Widget>[
          Container(child: titleLbl, margin: EdgeInsets.only(left: 10),),
          Expanded(child: Container(child: subLbl, margin: EdgeInsets.only(left: 10),),),
          Container(child: readAllBtn, margin: EdgeInsets.only(right: 7),),
          Container(child: rightIndicatorView, margin: EdgeInsets.only(right: 10),),

        ], 
      ),
    );

  }

  //MARK：规格
  Widget specificationItemWidget(String title, String subValue) {
    Text titleLbl = Text(
      title,
      style: TextStyle(fontSize: 14, color: Color(0xff333333)),
    );

    Text subLbl = Text(
      subValue,
      style: TextStyle(fontSize: 14, color: Color(0xffc9caca)),
    );

    Image rightIndicatorView = Image.asset("images/mall/fapiaoyoujiantou.png");

    return Container(
      color: Color(0xffffffff),
      height: 45,
      child: Row(
        children: <Widget>[
          Expanded(child: Container(child: titleLbl, margin: EdgeInsets.only(left: 10),),),
          Container(child: subLbl, margin: EdgeInsets.only(right: 7),),
          Container(child: rightIndicatorView, margin: EdgeInsets.only(right: 10),),

        ], 
      ),
    );
  }
 
}

//MAKR:评论项
class CommentItemView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Text commentMsg = Text(
      "服务态度非常好，给你们的服务点个赞，你们真棒。",
      style: TextStyle(fontSize: 13, color: Color(0xff333333)),
    );

    var imageView = ListView.builder(itemCount: 4, scrollDirection: Axis.horizontal,
    itemBuilder: (context, index){
      return Container(
            child: CachedNetworkImage(
                imageUrl: "https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=77d1cd475d43fbf2da2ca023807fca1e/9825bc315c6034a8ef5250cec5134954082376c9.jpg",
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                // width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
            // color: Colors.green,
            margin: EdgeInsets.only(left: 5, right: 5),
            width: 80, height: 80,);
    },);

    return Container(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      userInfo(),
      Container(child: commentMsg, margin: EdgeInsets.only(left: 10, top: 10),),
      Container(child: imageView, margin: EdgeInsets.only(left: 5, top: 10),height: 80,),
      Container(color: Colors.grey.withAlpha(70), height: 0.5,margin: EdgeInsets.only(left: 10, top: 15, right: 10),)

    ],),
    height: 173.5,);
  }

  Widget userInfo(){
    var avatarView = Container(
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: "https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=77d1cd475d43fbf2da2ca023807fca1e/9825bc315c6034a8ef5250cec5134954082376c9.jpg",
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                // width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(Radius.circular(12.5)),
            ),
            // color: Colors.green,
            margin: EdgeInsets.only(left: 10, top: 15),
            width: 25, height: 25,);

    Text niclLbl = Text(
      "张**",
      style: TextStyle(fontSize: 13, color: Color(0xff333333)),
    );

    return Container(child: Row(children: <Widget>[
      avatarView,
      Container(child: niclLbl,margin: EdgeInsets.only(left: 11, top: 11),)

    ],),);

  }

  
}
