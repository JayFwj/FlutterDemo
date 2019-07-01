import 'package:Flutter/chat/util/Util.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:event_bus/event_bus.dart';
import './Model/SocketMsgObj.dart';

class SocketUtil{

  EventBus eventBus = EventBus();

  ValueChanged<SocketMsgObj> onReceivedMsgCallback;
  String socketAddr = "ws://echo.websocket.org";
  IOWebSocketChannel socketChannel;

  // SocketUtil(this.onReceivedMsgCallback);
  SocketUtil(){
     socketChannel = IOWebSocketChannel.connect(socketAddr);
     socketChannel.stream.listen(onData, onError: onError, onDone: onDone);
  }

  static SocketUtil sharedInstance = SocketUtil();

  init(ValueChanged<SocketMsgObj> callback){
    this.onReceivedMsgCallback = callback;
   
    // socketChannel.stream.listen((msg) {
    //   var receivedMsg = msg.toString();
    //   print("receivedMsg ===$receivedMsg");
    //   onReceivedMsg(receivedMsg);
    // });
    
  }

  //发送消息
  sendMsg(String msg){
    socketChannel.sink.add(msg);
  }

  //关闭
  close(){
    socketChannel.sink.close();
  }

  //MARK:Socket回调
  onDone() {
    debugPrint("onDone Socket is closed");
    socketChannel = IOWebSocketChannel.connect(socketAddr);
  }

  onError(err) {
    debugPrint(err.runtimeType.toString());
    WebSocketChannelException ex = err;
    debugPrint(ex.message);
  }

  onData(event) {
    var receivedMsg = event.toString();
    var msgObj = SocketMsgObj(
        "Amy",
        "https://ss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=e73b6d7b913df8dcb93d8991fd1372bf/aec379310a55b3197c30e1f94da98226cefc1774.jpg",
        readTimestamp(DateTime.now().millisecondsSinceEpoch),
        true,msg: receivedMsg);
    eventBus.fire(msgObj);
    if(onReceivedMsgCallback != null){
      onReceivedMsgCallback(msgObj);
    }
  }

}