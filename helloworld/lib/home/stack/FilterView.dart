import 'package:flutter/material.dart';

class FilterView extends StatefulWidget{

  final String lastSelectedWords;
  final ValueChanged<String> onChanged;

  FilterView({Key key, this.lastSelectedWords, this.onChanged}) : super(key:key);
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FilterViewState();
  }
}

class FilterViewState extends State<FilterView>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: 
      Column(children: <Widget>[
        FlatButton(onPressed: (){
          widget.onChanged("I love you all");
      }, 
      color: Colors.orange,child: Text("Hide Filter View"),
      ),

      Container(
        child: Text(widget.lastSelectedWords != null ? widget.lastSelectedWords: "Not Selected",
        style: TextStyle(fontSize: 22, color: Colors.white),textAlign: TextAlign.center,) ,

        margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: 100,
      ),
      ],)
      ,
      color: Colors.black.withAlpha(80),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
  }
}