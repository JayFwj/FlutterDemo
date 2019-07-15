import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SilverListVC extends StatelessWidget {
  static final TextStyle _boldStyle =
      new TextStyle(fontWeight: FontWeight.bold);
  static final TextStyle _greyStyle = new TextStyle(color: Colors.grey);

  final ddlValues = <int>[1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var view = CustomScrollView(
      
      slivers: <Widget>[
        new SliverAppBar(
          backgroundColor: Colors.orange,
          actions: <Widget>[
            Icon(Icons.menu),
            Container(child: Icon(Icons.share), margin: EdgeInsets.only(right: 20),),

          ],
          expandedHeight: 180.0,
          pinned: true, 
          flexibleSpace: new FlexibleSpaceBar(
            title: const Text("Order Summary"),
            background: new Image.asset("images/lake.jpg", fit: BoxFit.cover),
          ),
        ),
        getPersistentHeader(),

        getSliverPadding(),
        getSliverToBox(),

        getSliverPadding(),
        getSliverToBox(),

        getSliverList(),

        getSliverGridExtent(),
      ],
    );

    return Container(child: view, color: Colors.white);
  }

  getPersistentHeader(){
    var header = SliverPersistentHeader(
      pinned: true, 
      delegate: _SliverAppBarDelegate(maxHeight: 100, 
      minHeight: 50, 
      child: Container(color: Colors.pink,)),

    );

    return header;
  }


  getSliverGridExtent(){
    List<Widget> childrenList = List<Widget>();

    var listStr = ["ABC",
    "ABCABCABCABC",
    "ABCABC",
    "ABCABC",
    "ABC",
    "ABCABCABCABCABC",
    "ABCABC",
    "ABC",
    "ABCABC",
    "ABC",];
    

    for(int i=0; i < listStr.length; i++){
      childrenList.add(
        Container(child: Text(listStr[i], style:TextStyle(fontSize:18)),
        decoration:BoxDecoration(border: Border.all(color: Colors.green, width: 1),
        color: Colors.white, 
        borderRadius: BorderRadius.all(Radius.circular(5))) ,)

      );
    }

    var sliverExtent = SliverGrid.extent(
      maxCrossAxisExtent: 150,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 3,
      children: childrenList,
    );
    return sliverExtent;
  }

  Widget getSliverList(){
    var sliverList = SliverList(delegate: SliverChildBuilderDelegate((builder, index){
      double height = (index * 50.0);
      return Container(height: height, 
        child: Text("Sliver List" ,style:TextStyle(fontSize:16)),
        decoration: BoxDecoration(color:Colors.deepOrangeAccent,
        border: Border.all(color: Colors.green, width: 1),
        ),
        );
    },childCount: 5),);
    
    return sliverList;
  }

  Widget getSliverToBox(){
     var sliverToBox = SliverToBoxAdapter(child: Container(color: Colors.orange, 
     child: Text("SliverToBox" ,style:TextStyle(fontSize:16)),
     height: 90,),);

     return sliverToBox;
  }

  Widget getSliverPadding(){
    var sliverPadding = SliverPadding(

          sliver: new SliverFixedExtentList(
            itemExtent: 90,
            delegate: SliverChildBuilderDelegate((builder, index) {
              return listItem(index);
            }, childCount: 5),
          ),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        );
      return sliverPadding;
  }

  Widget listItem(int index) {
    var view = Container(
      child: Text("第$index栏"),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2),
        color: Colors.grey,
      ),
    );
    return view;
  }
}



class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {

  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });
 
  final double minHeight;
  final double maxHeight;
  final Widget child;
 
  @override
  double get minExtent => minHeight;
 
  @override
  double get maxExtent => max(maxHeight, minHeight);
 
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }
 
  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
} 