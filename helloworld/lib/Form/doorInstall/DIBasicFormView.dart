import 'package:flutter/material.dart';

class DIBasicQuesItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

     var titleLbl = Text("问题描述", 
    style: TextStyle(fontSize: 14, color: Color(0xff666666)),);


    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 10, right: 10),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        Container(child: titleLbl, margin: EdgeInsets.only(top: 16),),
        Container(child: DIBasicFormView(), height: 100,margin: EdgeInsets.only(top: 8,bottom: 10),)
      ],)
    );
  }
}


class DIBasicFormView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DIBasicFormViewState();
  }
}

class _DIBasicFormViewState extends State<DIBasicFormView> {
  FocusNode focusNode = FocusNode();
  TextEditingController editingController = TextEditingController();
  int inputLen = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editingController.addListener((){
      setState(() {
        inputLen = editingController.text.length;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    EditableText editableText = EditableText(
      controller: editingController,
      focusNode: focusNode,
      minLines: 1,
      maxLines: 5,
      style: TextStyle(color: Color(0xffc9caca), fontSize: 14),
      cursorColor: Colors.black,
      backgroundCursorColor: Colors.black,
    );

    
    Text text = Text(inputLen.toString() + "/100");

    var richTxt = RichText(text: TextSpan(
      text: inputLen.toString() + "/",
      style: TextStyle(color:Color(0xffc9caca),fontSize: 12  ),
      children: [
        TextSpan(text: "100", style:TextStyle(color:Color(0xff666666),fontSize: 12  ) )
      ]
    ),);

    return Container(
      height: 100,
      padding: EdgeInsets.only(left: 8, top: 6, right: 8, bottom: 6),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xffcecece), width: 0.5),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Stack(
        children: <Widget>[
          Container(
            child: editableText,
            constraints: BoxConstraints(maxHeight: 88, minHeight: 30),
          ),
          Positioned(
            child: richTxt,
            right: 8,
            bottom: 8,
          )
        ],
      ),
    );
  }
}
