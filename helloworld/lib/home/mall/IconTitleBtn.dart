import 'package:flutter/widgets.dart';

class IconTitleBtn extends StatelessWidget{
  
  String icon;
  String title;

  IconTitleBtn(this.icon, this.title);  

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Image iconView = Image.asset(this.icon, width: 30, height: 30,);
    var titleView = Text(this.title,style:TextStyle(fontSize: 14, color: Color(0xff333333)));

    return Container(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      iconView,
      Container(child: titleView, margin: EdgeInsets.only(left: 8))
    ],),alignment: FractionalOffset.center,);
  }
}