import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WxMomentVc extends StatefulWidget {
  @override
  _WxMomentVcState createState() => _WxMomentVcState();
}

class _WxMomentVcState extends State<WxMomentVc> {
  List<MomentModel> momentsList = new List<MomentModel>();

  void loadData() {
    momentsList.add(MomentModel(
        "",
        "张三",
        "短暂的春天之后，热辣辣的夏天飞快的跑进我的世界。" +
            "想要女神一把穿着长裙过夏天，去商场里选中了一双鞋，试穿的时候觉得美美的，就毫不犹豫的带她回家。 " +
            "穿上长裙和鞋子，想象着自己“舞步翩翩”的出门，但却奈何事与愿违，" +
            "没走几步便觉得脚后跟被鞋子磨得生疼，每走一步都像是美人...",
        1,
        "1分钟前"));

    momentsList
        .add(MomentModel("", "张三", "短暂的春天之后，热辣辣的夏天飞快的跑进我的世界。", 4, "1分钟前"));

    momentsList
        .add(MomentModel("", "张三", "短暂的春天之后，热辣辣的夏天飞快的跑进我的世界。", 5, "1分钟前"));

    momentsList
        .add(MomentModel("", "张三", "短暂的春天之后，热辣辣的夏天飞快的跑进我的世界。", 2, "1分钟前"));

    momentsList
        .add(MomentModel("", "张三", "短暂的春天之后，热辣辣的夏天飞快的跑进我的世界。", 4, "1分钟前"));

    momentsList
        .add(MomentModel("", "张三", "短暂的春天之后，热辣辣的夏天飞快的跑进我的世界。", 9, "1分钟前"));

    momentsList
        .add(MomentModel("", "张三", "短暂的春天之后，热辣辣的夏天飞快的跑进我的世界。", 1, "1分钟前"));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadData();

    var listView = ListView.builder(
      itemCount: momentsList.length,
      itemBuilder: (context, index) {
        return MomentItemCell(momentsList[index]);
      },
    );
    return MaterialApp(
      title: 'Home',
      home: Scaffold(
        appBar: AppBar(
          title: Text("朋友圈"),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
        ),
        body: listView,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.pause,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

//MARK:列表项
class MomentItemCell extends StatelessWidget {
  MomentModel model;

  MomentItemCell(this.model);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var avatarView = Container(
      child: CachedNetworkImage(
        imageUrl:
            "https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=77d1cd475d43fbf2da2ca023807fca1e/9825bc315c6034a8ef5250cec5134954082376c9.jpg",
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
      ),
      width: 42,
      color: Colors.black,
      height: 42,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
    );
    var nicLbl = Padding(
      child: Text(model.nick,
          style: TextStyle(color: Color(0xff333333), fontSize: 16)),
      padding: EdgeInsets.only(top: 15),
    );

    var msgLbl = Padding(
      child: Text(model.msg,
          style: TextStyle(color: Color(0xff666666), fontSize: 14)),
      padding: EdgeInsets.fromLTRB(0, 8, 10, 0),
    );

    var imgsView = Container(
      child: MomentImgView(model.imageCount),
      margin: EdgeInsets.only(top: 4),
    );

    var timeLbl = Text(model.time,
        style: TextStyle(color: Color(0xff999999), fontSize: 12));
    var actionBtn = Container(
      child: InkWell(
        child: Icon(Icons.book),
        onTap: () {},
      ),
      margin: EdgeInsets.only(right: 11),
    );

    var timeActionsView = Row(
      children: <Widget>[
        timeLbl,
        Expanded(
          child: Container(
            color: Colors.orange,
          ),
        ),
        actionBtn
      ],
    );

    var divideLine = Container(
      height: 1,
      color: Color(0xffefefef),
      margin: EdgeInsets.only(top: 12),
    );

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                avatarView,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[nicLbl, msgLbl, imgsView, timeActionsView],
                )),
              ],
            ),
          ),
          divideLine
        ],
      ),
    );
  }
}

class MomentImgView extends StatelessWidget {
  int count = 0;

  MomentImgView(this.count);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (this.count == 1) {
      return oneImgView(context);
    } else if (count == 2) {
      return twoImgView(context);
    } else if (count == 4) {
      return fourImgView(context);
    }
    return twoImgView(context);
  }

  Widget oneImgView(BuildContext context) {
    var img = Container(
      child: imgView("", context),
      width: 120,
      color: Colors.black,
      height: 120,
    );
    return img;
  }

  Widget fourImgView(BuildContext context) {
    return Column(
      children: <Widget>[
        twoImgView(context),
        Container(
          child: twoImgView(context),
          margin: EdgeInsets.only(top: 4),
        )
      ],
    );
  }

  Widget twoImgView(BuildContext context) {
    var view = Row(
      children: <Widget>[
        imgViewContainer("", context, 100, 100, EdgeInsets.zero),
        imgViewContainer("", context, 100, 100, EdgeInsets.only(left: 4))
      ],
    );
    return view;
  }

  Widget imgViewContainer(String url, BuildContext context, double width,
      double height, EdgeInsets edgeInsets) {
    return Container(
      margin: edgeInsets,
      child: imgView("", context),
      width: width,
      height: height,
    );
  }

  Widget imgView(String url, BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          "https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=77d1cd475d43fbf2da2ca023807fca1e/9825bc315c6034a8ef5250cec5134954082376c9.jpg",
      placeholder: (context, url) => new CircularProgressIndicator(),
      errorWidget: (context, url, error) => new Icon(Icons.error),
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.fill,
    );
  }
}

class MomentModel {
  String avatar;
  String nick;
  String msg;

  int imageCount;

  String time;

  MomentModel(this.avatar, this.nick, this.msg, this.imageCount, this.time);
}
