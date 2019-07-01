import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_bus/event_bus.dart';
import '../Socket/Model/SocketMsgObj.dart';
import '../Socket/SocketUtil.dart';

class SessionListVC extends StatefulWidget {
  @override
  _SessionListVCState createState() => _SessionListVCState();
}

class _SessionListVCState extends State<SessionListVC> {
  SocketMsgObj msgObj;

  @override
  void initState() {
    super.initState();
    SocketUtil.sharedInstance.init(null);
    SocketUtil.sharedInstance.eventBus.on<SocketMsgObj>().listen((obj) {
      msgObj = obj;
      setState(() {});
    });
    msgObj = SocketMsgObj(
        "Jay",
        "https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=bc7f0508dea20cf45990f8df460b4b0c/9d82d158ccbf6c8165f7ae67b23eb13532fa4079.jpg",
        "09:21",
        false,
        msg: "1111");
  }

  @override
  Widget build(BuildContext context) {
    var listView = ListView.builder(
      padding: EdgeInsets.all(0),
      itemCount: 1,
      itemBuilder: (context, index) {
        return InkWell(
          child: HomeItemCell(msgObj),
          onTap: () {
            Navigator.pushNamed(context, "/SocketVC");
          },
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("消息"),
        elevation: 0,
      ),
      resizeToAvoidBottomPadding: false, //避免软键盘把widget顶上去
      body: Column(
        children: <Widget>[
          Container(
            child: HomeMsgNavView(),
          ),
          Flexible(
              child: Container(
            child: listView,
            color: Colors.white,
          ))
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigator.pushNamed(context, "/WxMomentVc");
          SocketUtil.sharedInstance.sendMsg("我爱你，我的家，我的家乡");
        },
        child: Icon(
          Icons.pause,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

//MARK：导航栏
class HomeMsgNavView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeMsgNavViewState();
  }
}

class _HomeMsgNavViewState extends State<HomeMsgNavView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var view = Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: 100,
    );
    var blueView = Container(
      color: Colors.blue,
      width: MediaQuery.of(context).size.width,
      height: 80,
    );

    var whiteView = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          menuItem("images/msgs/huodongxiaoxi.png", "活动消息", 0, 1),
          menuItem("images/msgs/zhaohutongzhi.png", "账户通知", 0, 0),
          menuItem("images/msgs/fuwutongzhi.png", "服务通知", 0, 0),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withAlpha(100), width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(10.5)),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 3,
                spreadRadius: 2,
                color: Colors.grey.withAlpha(60))
          ]),
      width: MediaQuery.of(context).size.width,
      height: 80,
    );

    return Stack(
      children: <Widget>[
        view,
        blueView,
        Positioned(
          child: whiteView,
          bottom: 8,
          left: 20,
          right: 20,
        )
      ],
    );
  }

  Widget menuItem(String icon, String title, double marginLeft, int count) {
    var unreadMsgCountLbl = ClipOval(
        child: Container(
      width: 20,
      height: 20,
      color: Colors.red,
      child: Center(
        child: Text("$count",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 8)),
      ),
    ));

    var countView = Positioned(
      child: unreadMsgCountLbl,
      top: 0,
      right: 18,
    );
    if (count > 0) {
      return Container(
        width: 100,
        height: 50,
        margin: EdgeInsets.only(left: marginLeft),
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(icon),
                  Container(
                    child: Text(title),
                    margin: EdgeInsets.only(top: 6),
                  )
                ],
              ),
              width: 100,
            ),
            countView
          ],
        ),
      );
    } else {
      return Container(
        width: 100,
        height: 50,
        margin: EdgeInsets.only(left: marginLeft),
        child: Column(children: <Widget>[
          Image.asset(icon),
          Container(
            child: Text(title),
            margin: EdgeInsets.only(top: 6),
          )
        ]),
      );
    }
  }
}

//MARK:列表项
class HomeItemCell extends StatefulWidget {
  SocketMsgObj msgObj;

  HomeItemCell(this.msgObj);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeItemCellState();
  }
}

class _HomeItemCellState extends State<HomeItemCell> {
  // String msg = "What do you do recently?";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var avatarView = Container(
      child: CachedNetworkImage(
        imageUrl: widget.msgObj.avatar,
        placeholder: (context, url) => new CircularProgressIndicator(),
        errorWidget: (context, url, error) => new Icon(Icons.error),
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.fill,
      ),
      width: 50, height: 50,
      margin: EdgeInsets.all(10),
      //  padding: EdgeInsets.all(10),
    );
    var nicLbl = Padding(
      child: Text(widget.msgObj.nick,
          style: TextStyle(color: Color(0xff333333), fontSize: 16)),
      padding: EdgeInsets.only(top: 12),
    );

    var lastMsgLbl = Container(
      height: 22,
      child: Text(widget.msgObj.msg,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Color(0xff666666), fontSize: 14,)),
      padding: EdgeInsets.fromLTRB(0, 4, 10, 0),
    );

    var lastMsgTimeLbl = Container(
      margin: EdgeInsets.fromLTRB(0, 15, 12, 0),
      height: 20,
      child: Text(widget.msgObj.time,
          style: TextStyle(color: Color(0xff666666), fontSize: 10)),
    );

    var unreadMsgCountLbl = Container(
      child: ClipOval(
          child: Container(
        width: 20,
        height: 20,
        color: Colors.red,
        child: Center(
          child: Text("3",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 8)),
        ),
      )),
      margin: EdgeInsets.only(right: 10),
    );

    var divideLine = Container(
      height: 1,
      color: Color(0xffefefef),
    );

    return Container(
      color: Colors.white,
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
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: nicLbl,
                          ),
                          lastMsgTimeLbl
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: lastMsgLbl,
                          ),
                          unreadMsgCountLbl
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          divideLine
        ],
      ),
    );
  }
}
