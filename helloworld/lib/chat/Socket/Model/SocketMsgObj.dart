import 'package:flutter/material.dart';
import 'dart:io';

class SocketMsgObj{

  File imgFile;
  String imgUrl;


  ChatMsgType msgType;
  String nick;
  String avatar;
  String msg;
  String time;
  bool receivedMsg;
  SocketMsgObj(this.nick, this.avatar, this.time, this.receivedMsg,
  {this.msgType = ChatMsgType.txt, this.msg, this.imgFile, this.imgUrl});
}

enum ChatMsgType{txt, image, address, voice}