import 'package:flutter/material.dart';
import './PickImageUtil.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';


class ChatInputView extends StatefulWidget{


final ValueChanged<String> sendTxtCallback;
final ValueChanged<dynamic> sendImgCallback;

ChatInputView({Key key, this.sendTxtCallback, this.sendImgCallback});

@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChatInputViewState();
  }
}

class _ChatInputViewState extends State<ChatInputView>{

  PickImageUtil imageUtil;
  FocusNode _contentFocusNode = FocusNode();
  TextEditingController _controller = TextEditingController();
  bool showMore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageUtil = new PickImageUtil(_sendImage);

    KeyboardVisibilityNotification().addNewListener(
    onChange: (bool visible) {
      print(visible);
      if(visible && showMore){
        setState(() {
          showMore = false;
        });
      }
    },
  );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return bottomInputView();
  }

  Widget bottomInputView(){
    return Container(
              height: showMore ? 150  : 50,
              color: Colors.white,
              child: Column(children: <Widget>[
                Container(color: Colors.grey, height: 1,),
                
                Flexible(child: Row(children: <Widget>[
                  Flexible(child: 
                  Container(padding: EdgeInsets.only(left: 10), child: Form(
                    child: TextFormField(
                      focusNode: _contentFocusNode,
                    controller: _controller,
                    // keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(hintText: '请输入要发送的消息', border: InputBorder.none),
                    ),
                  ),),
                  ),
                  Container(child: FlatButton(child: Icon(Icons.more),onPressed: _showMoreAction,),width: 50,),
                  Container(child: FlatButton(child: Icon(Icons.send),onPressed: _sendMessage,),width: 50,)
              ],),),
              Container(color: Colors.grey, height: 1,),
              showMore ? moreView(): Container(height: 0,),

              ],)
            );
  }

  Widget moreView(){
      return Container(height: 100, child: Row(children: <Widget>[
        FlatButton(child: Text("拍照"),onPressed: (){
          imageUtil.takePicture();
        },),
        FlatButton(child: Text("相册"), onPressed: (){
          imageUtil.getImageFromAlbum();
        },)
      ],),);
  }

  //显示更多菜单
  void _showMoreAction(){
    _contentFocusNode.unfocus();
      setState(() {
        showMore = !showMore;
      });
  }
  //发送文本消息
  void _sendMessage(){
    if(_controller.text.isNotEmpty){
      widget.sendTxtCallback(_controller.text);
      _controller.text = "";
    }
  }
  //发送图片
  void _sendImage(dynamic imageFile){
    widget.sendImgCallback(imageFile);
    setState(() {
        showMore = false;
      });
  }
}

