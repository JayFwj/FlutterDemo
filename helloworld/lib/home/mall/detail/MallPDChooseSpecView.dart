import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MallPDChooseSpecView extends StatefulWidget{

  VoidCallback dismissCallback;

  MallPDChooseSpecView(this.dismissCallback);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MallPDChooseSpecViewState();
  }

}

class _MallPDChooseSpecViewState extends State<MallPDChooseSpecView>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
 
    return Container(child: Stack(children: <Widget>[

       Opacity(child:InkWell(child: Container(color: Colors.black,), onTap: (){widget.dismissCallback();},),  opacity: 0.2,),

      Positioned(child: bodyView(), bottom: 0, left: 0, right: 0,)

    ],),);
   
  }

  Widget bodyView(){
    return Container(color: Colors.white,height: 350,);
  }

  Widget dimisssView(){
    return Container(color: Colors.green);
  }
  //margin: EdgeInsets.only(bottom: 0, left: 0, right: 0)
}
