import 'package:flutter/material.dart';
import './ScrollHeaderView.dart';

class ScrollChangeLayoutVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScrollChangeLayoutVCState();
  }
}

class ScrollChangeLayoutVCState extends State<ScrollChangeLayoutVC> {

  double offset = 0;
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {

    var listView = ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 90,
      itemBuilder: (context, index) {
        return ListTile(title: Text("Title $index"),);
      },
    );

     _scrollController.addListener(() {
      double offset = _scrollController.offset;
      //print("Scroll Offset ==>$offset");

      setState(() {
        this.offset = offset;
      });
    });

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Scroll"),),
        body: Container(
        child: Column(
          children: <Widget>[
            ScrollHeaderView(offset),

            Expanded(child: 
            Container(child: listView,
            margin: EdgeInsets.only(top: 0),
            color: Colors.white,),)
            // listView,
          ],
        ),
        color: Colors.grey,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
    ),

    );
  }
}