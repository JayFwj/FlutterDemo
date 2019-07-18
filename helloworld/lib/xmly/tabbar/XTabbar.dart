import 'package:Flutter/r.dart';
import 'package:Flutter/xmly/discover/XDiscover.dart';
import 'package:Flutter/xmly/home/XHome.dart';
import 'package:Flutter/xmly/mine/XMine.dart';
import 'package:flutter/material.dart';

class XTabbar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _XTabbarState();
  }
}

class _XTabbarState extends State<XTabbar> {
  int _tabIndex = 0;
  var tabImages;

  @override
  Widget build(BuildContext context) {
    var menusView = GridView(
      children: <Widget>[
        HomeBottomMenuItem(
          icon: R.resourcesImagesHomeShouyekongPng,
          activeIcon: R.resourcesImagesHomeShouyeshiPng,
          title: "首页",
          index: 0,
          selected: _tabIndex == 0,
          selectedCallback: menuItemSelectedCallback,
        ),
        HomeBottomMenuItem(
          icon: R.resourcesImagesHomeXiaoxikongPng,
          activeIcon: R.resourcesImagesHomeXiaoxishiPng,
          title: "我听",
          index: 1,
          selected: _tabIndex == 1,
          selectedCallback: menuItemSelectedCallback,
        ),
        HomeBottomCenterMenuItem(),
        HomeBottomMenuItem(
          icon: R.resourcesImagesHomeGouwuchekongPng,
          activeIcon: R.resourcesImagesHomeGouwucheshiPng,
          title: "发现",
          index: 2,
          selected: _tabIndex == 2,
          selectedCallback: menuItemSelectedCallback,
        ),
        HomeBottomMenuItem(
          icon: R.resourcesImagesHomeWodekongPng,
          activeIcon: R.resourcesImagesHomeWodeshiPng,
          title: "账号",
          index: 3,
          selected: _tabIndex == 3,
          selectedCallback: menuItemSelectedCallback,
        ),
      ],
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: kBottomNavigationBarHeight,
          childAspectRatio: 1,
          crossAxisSpacing: 20),
    );

    var bottomMenusView = Container(
      child: Column(
        children: <Widget>[
          Container(
            color: Color(0xffd4d4d4),
            height: 1,
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: menusView,
          )),
        ],
      ),
      height: kBottomNavigationBarHeight,
    );

    // TODO: implement build
    return Scaffold(
      // body: _bodys[_tabIndex],
      body: IndexedStack(
        children: <Widget>[
          new XHome(),
          new XDiscover(),
          new XDiscover(),
          new XMine(),
        ],
        index: _tabIndex,
      ),
      bottomNavigationBar: bottomMenusView,
    );
  }

  menuItemSelectedCallback(int menuIndex) {
    this._tabIndex = menuIndex;
    setState(() {});
  }
}

class HomeBottomCenterMenuItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeBottomCenterMenuItemState();
  }
}

class _HomeBottomCenterMenuItemState extends State<HomeBottomCenterMenuItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(R.resourcesXmlyFeedBtnPlayPng),
      // color: Colors.orange,
    );
  }
}

//Bottom Menu item
class HomeBottomMenuItem extends StatefulWidget {
  String icon;
  String activeIcon;
  String title;
  int index;
  bool selected = false;
  ValueChanged<int> selectedCallback;

  HomeBottomMenuItem(
      {this.icon,
      this.activeIcon,
      this.title,
      this.index,
      this.selected,
      this.selectedCallback});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeBottomMenuItemState();
  }
}

class _HomeBottomMenuItemState extends State<HomeBottomMenuItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (this.widget.selected == null) {
      this.widget.selected = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Image.asset(this.widget.selected
                    ? this.widget.activeIcon
                    : this.widget.icon),
                margin: EdgeInsets.only(top: 10),
                height: 22
                // ,color: Colors.orange,
                ),
            Container(
              child: Text(this.widget.title,
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(
                          this.widget.selected ? 0xff000000 : 0xff6c6c6c))),
              margin: EdgeInsets.only(top: 2),
            )
          ],
        ),
      ),
      onTap: () {
        this.widget.selectedCallback(this.widget.index);
      },
    );
  }
}
