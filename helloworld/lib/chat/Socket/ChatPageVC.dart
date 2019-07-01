import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './Model/SocketMsgObj.dart';
import 'MsgListCell.dart';
import './PickImageUtil.dart';
import './ChatInputView.dart';
import './SocketUtil.dart';

class ChatPageVC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = '美的品牌服务商';
    return MyHomePage(
      title: title,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  _MyHomePageState _state;
  MyHomePage({Key key, @required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() {
    _state = _MyHomePageState();
    return _state;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  
  bool addedSocketListen = false;
  List<SocketMsgObj> msgList = new List<SocketMsgObj>();

  ScrollController _scrollController = new ScrollController();

  SocketUtil socketUtil;
  PickImageUtil imageUtil;
  bool showMore = false; 

  @override
  void initState() {
    super.initState();
    socketUtil = SocketUtil.sharedInstance;
    socketUtil.init(onReceivedMsg);
  }

  void onReceivedMsg(SocketMsgObj msgObj) {
    
    setState(() {
      msgList.add(msgObj);
    }); 
  }

  moveToLastRow(){  
    _scrollController.animateTo(_scrollController.position.maxScrollExtent ,
        duration: Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    var listView = ListView.builder(
      controller: _scrollController,
      itemCount: msgList.length,
      itemBuilder: (context, index) {
        var msgObj = msgList[index];
        if(msgObj.msgType == ChatMsgType.image){
          if(msgObj.imgUrl != null){
              return ImgMsgView(msgObj.receivedMsg, msgObj.avatar, url: msgObj.imgUrl,);
          }else{
              return ImgMsgView(msgObj.receivedMsg, msgObj.avatar, imageFile: msgObj.imgFile,);
          }
        }else{
           if (msgObj.receivedMsg) {
            return TxtMsgView(msgObj.msg,true,msgObj.avatar);
          } else {
           return TxtMsgView(msgObj.msg,false,msgObj.avatar);
         }
        } 
      },
    ); 
    if(msgList.length > 5){
      moveToLastRow(); 
    } 
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: FlatButton(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              child: listView,
            ),
            ChatInputView(sendTxtCallback: _sendTxtMsg,sendImgCallback: _sendImgMsg,),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     imageUtil.showPickImageActionSheet(context);
      //   },
      //   tooltip: 'Send message',
      //   child: Icon(Icons.send),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
//MARK:发送消息
  _sendTxtMsg(String msg){
      setState(() {
        msgList.add(SocketMsgObj(
            "Jay",
            "https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=bc7f0508dea20cf45990f8df460b4b0c/9d82d158ccbf6c8165f7ae67b23eb13532fa4079.jpg",
            "2019-09-02 11:22",
            false,msg: msg)); 
      });
      socketUtil.sendMsg(msg);
  } 

  //发送图片
  void _sendImgMsg(dynamic imageFile){
    if(imageFile == null){
      return;
    }
    msgList.add(SocketMsgObj(
            "Jay",
            "https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=bc7f0508dea20cf45990f8df460b4b0c/9d82d158ccbf6c8165f7ae67b23eb13532fa4079.jpg",
            "2019-09-02 11:22",
            false,
            imgFile: imageFile,
            msgType: ChatMsgType.image)); 
     setState(() {      });
  }
  @override
  void dispose() {
   // socketUtil.close();
    super.dispose();
    print("===dispose==");
  }
}
