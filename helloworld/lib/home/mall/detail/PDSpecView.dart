import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PDSpecView extends StatefulWidget{
@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PDSpecViewState();
  }
}

class _PDSpecViewState extends State<PDSpecView>{

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    var specList = ["智能家居型","普通型","经济实惠型","家庭宜居型","超级搭配型"];
    List<Widget> views = List<Widget>();

    for(int i=0;i<specList.length;i++){
      var item = InkWell(child: specItemView(specList[i], i == this.selectedIndex),onTap: (){
          this.selectedIndex = i;
          setState(() {});
      },);
      views.add(item);
    }

    var gridView = GridView(
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 148.0,
              childAspectRatio: 3.6,
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0),
      children: 
      views,);

//     var gridView = StaggeredGridView.countBuilder(
//   crossAxisCount: 4,
//   itemCount: 8,
//   itemBuilder: (BuildContext context, int index) => new Container(
//       color: Colors.green,
//       child: new Center(
//         child: new CircleAvatar(
//           backgroundColor: Colors.white,
//           child: new Text('$index'),
//         ),
//       )),
//   staggeredTileBuilder: (int index) =>
//       new StaggeredTile.count(2, index.isEven ? 2 : 1),
//   mainAxisSpacing: 4.0,
//   crossAxisSpacing: 4.0,
//   physics: NeverScrollableScrollPhysics(),
// );
 

    return  Container(color: Colors.white, height: 320,child: gridView,margin: EdgeInsets.only(top:15, left: 15, right: 15 ),);

  }

  Widget specItemView(String title, bool selected){
    var normalColor = Color(0xfff4f8fa);
    var selectedColor = Color(0xffebf8ff);
    var normalTxtColor = Color(0xff333333);

    var selectedBorderColor = Color(0xff139ef6);
    var container =
    //  ClipRRect(borderRadius: BorderRadius.all(Radius.circular(14)),
    // child: 
    Container(
      decoration: BoxDecoration(color: selected ? selectedColor : normalColor,  
          borderRadius: BorderRadius.all(Radius.circular(14)),
           border: Border.all(color: selected ? selectedBorderColor : normalColor, width: 1)),
    child: Align(child: Text(title,textAlign: TextAlign.center,style: TextStyle(color: selected ? selectedBorderColor : normalTxtColor),) ,alignment: FractionalOffset.center,),
    padding: EdgeInsets.only(left: 10, right: 10,top: 5, bottom: 5),);//,);

    return container ;//Container(height: 40, width: 100, color: Colors.red);
  }
}

