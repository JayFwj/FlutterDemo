import 'package:Flutter/radialBtn/src/radial_menu.dart';
import 'package:Flutter/radialBtn/src/radial_menu_item.dart';
import 'package:flutter/material.dart';

enum MenuOptions {
  unread,
  share,
  archive,
  delete,
  backup,
  copy,
}

class RadialBtnTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    GlobalKey<RadialMenuState> _menuKey = new GlobalKey<RadialMenuState>();

  final List<RadialMenuItem<MenuOptions>> items = <RadialMenuItem<MenuOptions>>[
    new RadialMenuItem<MenuOptions>(
      value: MenuOptions.unread,
      child: new Icon(
        Icons.markunread,
      ),
      iconColor: Colors.white,
      backgroundColor: Colors.blue[400],
      tooltip: 'unread',
    ),
    new RadialMenuItem<MenuOptions>(
      value: MenuOptions.share,
      child: new Icon(
        Icons.share,
      ),
      iconColor: Colors.white,
      backgroundColor: Colors.green[400],
    ),
    new RadialMenuItem<MenuOptions>(
      value: MenuOptions.archive,
      child: new Icon(
        Icons.archive,
      ),
      iconColor: Colors.white,
      backgroundColor: Colors.yellow[400],
    ),
    new RadialMenuItem<MenuOptions>(
      value: MenuOptions.delete,
      child: new Icon(
        Icons.delete,
      ),
      iconColor: Colors.white,
      backgroundColor: Colors.red[400],
    ),
    new RadialMenuItem<MenuOptions>(
      value: MenuOptions.backup,
      child: new Icon(
        Icons.backup,
      ),
      iconColor: Colors.white,
      backgroundColor: Colors.black,
    ),
    new RadialMenuItem<MenuOptions>(
      value: MenuOptions.copy,
      child: new Icon(
        Icons.content_copy,
      ),
      iconColor: Colors.white,
      backgroundColor: Colors.indigo[400],
    ),
  ];

  void _onItemSelected(MenuOptions value) {
    print(value);
  } 
   
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Radial"),),
        body: new Center(
          child:
          ListView(children: <Widget>[
            Container(height: 300,child:new RadialMenu(
            key: _menuKey,
            items: items,
            radius: 100.0,
            onSelected: _onItemSelected,
          ) ,),
           
           Container(height: 100, child: RAnimateView(),)

          ],)
           
        ),
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.restore),
          onPressed: () => _menuKey.currentState.reset(),
        ),
      );
  }
}


class RAnimateView extends StatefulWidget{
@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RAnimateViewState();
  }
}

class _RAnimateViewState extends State<RAnimateView> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {

    var progress = new Tween(begin: 0.0, end: 1.0).animate(
          new CurvedAnimation(
            parent: AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    ),
            curve: new Interval(
              0.0,
              0.5,
              curve: Curves.ease,
            ),
          ),
        );

    // TODO: implement build
    return  AnimatedIcon(
      color: Colors.blue,
      icon: AnimatedIcons.menu_close,
      progress: progress,
    );
  }
}