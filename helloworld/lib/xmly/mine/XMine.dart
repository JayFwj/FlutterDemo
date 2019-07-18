import 'package:Flutter/r.dart';
import 'package:Flutter/xmly/mine/XMineNavView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class XMine extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _XMineState();
  }
}

class _XMineState extends State<XMine>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ListView listView = ListView(
      children: <Widget>[
        Xmineheader("https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=77d1cd475d43fbf2da2ca023807fca1e/9825bc315c6034a8ef5250cec5134954082376c9.jpg",
        "Jay_rj","10","3", "5"),

        XVIPRow(),

        XMineFunRowOneView(),

        XMineService(titleStr: "我的服务", menuList: [
          XMineMenuModel(titleStr: "我的钱包", iconStr: R.resourcesImagesHomeShoujiPng),
          XMineMenuModel(titleStr: "我的已购", iconStr: R.resourcesImagesHomeShoujiPng),
          XMineMenuModel(titleStr: "我的等级", iconStr: R.resourcesImagesHomeShoujiPng),
          XMineMenuModel(titleStr: "我的积分", iconStr: R.resourcesImagesHomeShoujiPng),

          XMineMenuModel(titleStr: "我的圈子", iconStr: R.resourcesImagesHomeShoujiPng),
          XMineMenuModel(titleStr: "我的客服", iconStr: R.resourcesImagesHomeShoujiPng),
          XMineMenuModel(titleStr: "推荐有礼", iconStr: R.resourcesImagesHomeShoujiPng),

        ],),

        XMineService(titleStr: "必备工具", menuList: [
          XMineMenuModel(titleStr: "扫一扫", iconStr: R.resourcesImagesHomeShoujiPng),
          XMineMenuModel(titleStr: "夜间模式", iconStr: R.resourcesImagesHomeShoujiPng),
          XMineMenuModel(titleStr: "驾驶模式", iconStr: R.resourcesImagesHomeShoujiPng),
          XMineMenuModel(titleStr: "定时关闭", iconStr: R.resourcesImagesHomeShoujiPng),

          XMineMenuModel(titleStr: "未成年模式", iconStr: R.resourcesImagesHomeShoujiPng),
        ],),

        XMineService(titleStr: "其它服务", menuList: [
          XMineMenuModel(titleStr: "知识大使", iconStr: R.resourcesImagesHomeShoujiPng),
          XMineMenuModel(titleStr: "联名信用卡", iconStr: R.resourcesImagesHomeShoujiPng),
          XMineMenuModel(titleStr: "运营商服务", iconStr: R.resourcesImagesHomeShoujiPng),
          XMineMenuModel(titleStr: "官方商城", iconStr: R.resourcesImagesHomeShoujiPng),

          XMineMenuModel(titleStr: "喜马福利社", iconStr: R.resourcesImagesHomeShoujiPng),
          XMineMenuModel(titleStr: "商家福利", iconStr: R.resourcesImagesHomeShoujiPng),
        ],),

        // XMineService("必备工具"),

        // XMineService("其它服务"),

        SizedBox(height: 20,),
      ],
    );

    return Scaffold(
      appBar: XMineNavView(),

      body: Container(child: listView,
      color: Color(0xfffbf8f9),),

    );
  }
}

class Xmineheader extends StatelessWidget{

  String avatarUrl;
  String nick;
  String fansCount;
  String attenCount;
  String score;

  Xmineheader(this.avatarUrl, this.nick, this.fansCount, this.attenCount, this.score);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var avatar = CachedNetworkImage(
        imageUrl:  this.avatarUrl,
        //"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=77d1cd475d43fbf2da2ca023807fca1e/9825bc315c6034a8ef5250cec5134954082376c9.jpg",
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
      );

    var nickLbl = Text(this.nick, 
    style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),);

    var fansCountLbl = Text("粉丝 "+this.fansCount, 
    style: TextStyle(color: Color(0xff848586), fontSize: 12),);

    var attenCountLbl = Text("关注 "+this.attenCount, 
    style: TextStyle(color: Color(0xff848586), fontSize: 12),);

    var scoreLbl = Text("+"+this.score + "积分", 
    style: TextStyle(color: Colors.orange, fontSize: 12),);

    var scroreView = ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(17.5),bottomLeft:  Radius.circular(17.5)),
      child: Container( 
        width: 100,
        height: 35,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff3b3c55),
              Color(0xff555479),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )

        ),
        child: Container(child: Row(children: <Widget>[Expanded(child: Container(),),
        Container(child: scoreLbl, margin: EdgeInsets.only(right: 10),)],
         crossAxisAlignment: CrossAxisAlignment.center,)),
      ),
    );

    var container = Container(
      height: 90 ,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(child:ClipRRect(child:  avatar,
          borderRadius: BorderRadius.all(Radius.circular(32.5)),) ,
          width: 65, height: 65,
          margin: EdgeInsets.only(left: 12),),

          Container(
            margin: EdgeInsets.only(left: 12,),
            child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            nickLbl,
            
            Container(child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              fansCountLbl,
             
              Container(color: Colors.grey.withAlpha(120) , width: 1,height: 12,
              margin: EdgeInsets.only(left: 8, right: 8),),
             
              attenCountLbl,
            ],),
            margin: EdgeInsets.only(top: 8),
            )
          ],)
          ,),

          Expanded(child: Container(),),

          scroreView

        ],
      ),
    );

    return container;
  }
}


//MARK:VIP行
class XVIPRow extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var vipLbl = Text("VIP会员", 
    style: TextStyle(color: Colors.orange, fontSize: 14),);

    var vipdescLbl = Text("会员首月仅6元", 
    style: TextStyle(color: Colors.orange.withAlpha(100), fontSize: 14),);

    var vipIcon = Image.asset(R.resourcesImagesHomeDiannaoPng);

    var indicator = Icon(Icons.arrow_right);

    return Container(
      margin: EdgeInsets.only(left: 12, right: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
           padding: EdgeInsets.all(10),
          child: Row(
          children: <Widget>[
            Container(child: vipIcon,
            margin: EdgeInsets.only(left: 12),),

            Container(child: vipLbl,
            margin: EdgeInsets.only(left: 12),),

            Expanded(child: Container(),),

            vipdescLbl,
 
            Container(child: indicator,
            margin: EdgeInsets.only(left: 6, right: 0),) 
          ],
        ),
        color: Color(0xfffaf5f1),
        ),
      ),

    );
  }
}


class XMineFunRowOneView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 85,
      margin: EdgeInsets.only(left: 12, right: 12, top: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          padding: EdgeInsets.only(top: 9.5, bottom: 9.5, left: 16),
          child: Row(
          children: <Widget>[
            Expanded(child: 
             Container( 
              //  color: Colors.green,
               child: 
             GridView(children: <Widget>[ 
              XMineMenuItem(XMineMenuModel(titleStr: "我要录音", iconStr: R.resourcesImagesHomeShoujiPng)),
              XMineMenuItem(XMineMenuModel(titleStr: "我要直播", iconStr: R.resourcesImagesHomeShoujiPng)),
              XMineMenuItem(XMineMenuModel(titleStr: "我的作品", iconStr: R.resourcesImagesHomeShoujiPng)),
            ],
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 66.0,
              childAspectRatio: 1,
              crossAxisSpacing: 30

            ),
            ),
            margin: EdgeInsets.only(top: 5,right: 16)
             ,)
            ,),

          Container(color: Colors.grey, width: 1, height: 50,),

          Container(child: 
          XMineMenuItem(XMineMenuModel(titleStr: "创作中心", iconStr: R.resourcesImagesHomeShoujiPng)),
          margin: EdgeInsets.only(left: 12, right: 12),)

          ],
        ),
        color: Colors.white
        ),
      ),

    );
  }
}


//MARK:我的服务
class XMineService extends StatelessWidget{

  String titleStr;

  List<XMineMenuModel> menuList;

  XMineService({this.titleStr, this.menuList});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var titlelbl = Text(this.titleStr, style: TextStyle(fontSize: 12),);

    var gridView = GridView.builder(
      itemCount: this.menuList.length,
      itemBuilder: (context, index){
        return XMineMenuItem(this.menuList[index]);
      },
       physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 66.0,
              childAspectRatio: 1,
              crossAxisSpacing: 30,
              mainAxisSpacing: 14

            ),
    ); 

    return Container(
      height: 204,
      margin: EdgeInsets.only(left: 12, right: 12, top: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(child: titlelbl,height: 30,
              margin: EdgeInsets.only(left: 12,top: 14),),

              Expanded(child: Container(child: gridView,
              // color: Colors.green,
              margin: EdgeInsets.only(left: 8, right: 8, top: 6),),)
            ],
          ),
        color: Colors.white
        ),
      ),

    );
  }
}

//MARK:Item
class XMineMenuItem extends StatelessWidget{
 
 XMineMenuModel model;

  XMineMenuItem(this.model);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width:66 ,
      height: 66,
      // color: Colors.pink,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(this.model.iconStr),
          Container(child: Text(this.model.titleStr, style: TextStyle(fontSize: 12),),
          margin: EdgeInsets.only(top: 6),)
        ],
      ),
    );
  }
}

class XMineMenuModel{
  String iconStr;
  String titleStr;
  VoidCallback callback;
  XMineMenuModel({this.iconStr, this.titleStr, this.callback});
}
