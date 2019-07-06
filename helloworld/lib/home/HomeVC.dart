import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './SelectionScreen.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:cached_network_image/cached_network_image.dart';
import './Model/HomeDataModel.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../API/HKAPI.dart';
import '../API/Home/HomeModel.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  List<HomeDataItem> dataList = new List<HomeDataItem>();
  List<HomeDataItem> defaultDataList = new List<HomeDataItem>();
  var isDefaultdata = true;

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadBanners();
    loadBrandData();
    dataList.add(new HomeIndustryItem());
    defaultDataList = dataList;
  }

  void loadStaticData() {
    // HomeBannerItem bannerItem = new HomeBannerItem();
    // bannerItem.banners = [
    //   "https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=77d1cd475d43fbf2da2ca023807fca1e/9825bc315c6034a8ef5250cec5134954082376c9.jpg",
    //   "https://ss3.baidu.com/-fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=b5e4c905865494ee982209191df4e0e1/c2cec3fdfc03924590b2a9b58d94a4c27d1e2500.jpg",
    //   "https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=0c78105b888ba61ec0eece2f713597cc/0e2442a7d933c8956c0e8eeadb1373f08202002a.jpg",
    // ];
    // dataList.add(bannerItem);
    // dataList.add(new HomeRecItem());
    // dataList.add(new HomeRecTitleItem("推荐品牌"));
    // dataList.add(new HomeBrandItem("美的服务品牌服务商"));
    // dataList.add(new HomeBrandItem("格力服务品牌服务商"));
    // dataList.add(new HomeBrandItem("海尔服务品牌服务商"));

    // dataList.add(new HomeRecTitleItem("家电品牌"));
    // dataList.add(new HomeBrandItem("家电1服务品牌服务商"));
    // dataList.add(new HomeBrandItem("家电2服务品牌服务商"));
    // dataList.add(new HomeBrandItem("家电3服务品牌服务商"));
  }

  Future<void> loadBanners() async {
    HomeBannerItem bannerItem = new HomeBannerItem();
    bannerItem.banners = await HKAPI.shaderInstance.homeBanner();
    setState(() {
      dataList.insert(0, bannerItem);
    });
  }

  Future<void> loadBrandData() async {
    HomeBrandData brandData = await HKAPI.shaderInstance.homeBrand();
    if (brandData != null) {
      var list = brandData.brandTypeList;
      for (var item in list) {
        if (item.typeName == "品牌推荐") {
          dataList.add(new HomeRecTitleItem(item.typeName, true));
          HomeRecItem recItem = HomeRecItem();
          recItem.brandList = item.brandList;
          dataList.add(recItem);
        } else {
          dataList.add(new HomeRecTitleItem(item.typeName, false));
          var items = item.brandList;
          dataList.addAll(items);
        }
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var listView = ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        var item = dataList[index];
        if (item is HomeBannerItem) {
          return HomeADView(items: item.banners);
        } else if (item is HomeIndustryItem) {
          return IndustryRowView();
        } else if (item is HomeRecItem) {
          return RecommandBrandView(item);
        } else if (item is HomeRecTitleItem) {
          return SectionItemView(item);
        } else if (item is HomeBrandDataItem) {
          return BrandItemView(item);
        }
      },
    );

    _scrollController.addListener(() {
      double offset = _scrollController.offset;
      print("Scroll Offset ==>$offset");

      /*
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !this.isRefreshing &&
          !this.isNoMoreData) {
        // 滑动到最底部了
        _getData();
      }
       */
    });

    var refreshListView = LiquidPullToRefresh(
      onRefresh: _handleRefresh, // refresh callback
      child: listView, // scroll view
      showChildOpacityTransition: false,
    );
//
    var overlayView = GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, "/TouchMoveView");
        //Navigator.pushNamed(context, "/FilterVC");
        // Navigator.pushNamed(context, "/FadeinAnimVC");
        // Navigator.pushNamed(context, "/LoadingProgressVC");
        
      },
      child: Container(
        color: Colors.orange,
        width: MediaQuery.of(context).size.width,
        height: 30,
      ),
    );

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor:Colors.black,
      statusBarColor: Colors.black));
    return Scaffold(
      appBar: HomeNavBarView(),
      // appBar: AppBar(title: Text("2"),brightness: Brightness.light,),
        body: Container(
        child: Stack(
          children: <Widget>[
            refreshListView,
            overlayView
          ],
        ),
      ),
    );
  }

  Future<void> _handleRefresh() async {
    if (isDefaultdata) {
      var url =
          "https://suggest.taobao.com/sug?code=utf-8&q=%E5%8D%AB%E8%A1%A3";

      // Await the http get response, then decode the json-formatted responce.
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        var result = jsonResponse['result'].cast<List>();

        // var tempList = result
        //     .map<HomeBrandItem>((json) => HomeBrandItem.fromJson(json))
        //     .toList();
        // setState(() {
        //   dataList = tempList;
        // });
      } else {
        print("Request failed with status: ${response.statusCode}.");
      }
    } else {
      setState(() {
        dataList = defaultDataList;
      });
    }

    isDefaultdata = (!isDefaultdata);
  }
}

//=====page view start
class HomeADView extends StatefulWidget {
  List<HomeBanner> items;
  HomeADView({Key key, this.items}) : super(key: key);

  @override
  HomeADViewState createState() {
    return new HomeADViewState();
  }
}

class HomeADViewState extends State<HomeADView> {
  // final _items = [
  //   "https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=77d1cd475d43fbf2da2ca023807fca1e/9825bc315c6034a8ef5250cec5134954082376c9.jpg",
  //   "https://ss3.baidu.com/-fo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=b5e4c905865494ee982209191df4e0e1/c2cec3fdfc03924590b2a9b58d94a4c27d1e2500.jpg",
  //   "https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=0c78105b888ba61ec0eece2f713597cc/0e2442a7d933c8956c0e8eeadb1373f08202002a.jpg",
  // ];

  HomeADViewState();

  final _pageController = PageController();
  final _currentPageNotifier = ValueNotifier<int>(0);
  final _boxHeight = 120.0;

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  _buildBody() {
    return Stack(
      children: <Widget>[
        _buildPageView(),
        _buildCircleIndicator(),
      ],
    );
  }

 

  _buildPageView() {

     List<Widget> banners = List<Widget>();
  for(var item in widget.items) {

    banners.add(Container(
      child: 
    ClipRRect( child: 
    CachedNetworkImage(
                imageUrl: item.image,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                // width: MediaQuery.of(context).size.width,
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(Radius.circular(5))
    ,),
    // color: Colors.green,
    margin: EdgeInsets.only(left: 5, right: 5),
    width: MediaQuery.of(context).size.width
    )
    );
  } 

  CarouselSlider slider = CarouselSlider(
  height: _boxHeight,
   items: banners, 
   viewportFraction: 0.9,
   enlargeCenterPage: true,
   );

    return Container(
      width:MediaQuery.of(context).size.width ,
      // color: Colors.orange,
      height: _boxHeight,
      child:slider
      //  PageView.builder(
      //     itemCount: widget.items.length,
      //     controller: _pageController,
      //     itemBuilder: (BuildContext context, int index) {
      //       return Center(
      //         child: CachedNetworkImage(
      //           imageUrl: widget.items[index].image,
      //           placeholder: (context, url) => new CircularProgressIndicator(),
      //           errorWidget: (context, url, error) => new Icon(Icons.error),
      //           width: MediaQuery.of(context).size.width,
      //           fit: BoxFit.fill,
      //         ),
      //       );
      //     },
      //     onPageChanged: (int index) {
      //       _currentPageNotifier.value = index;
      //     }),
    );
  }

  _buildCircleIndicator() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CirclePageIndicator(
          itemCount: widget.items.length,
          currentPageNotifier: _currentPageNotifier,
        ),
      ),
    );
  }
}

//====page view end

class TitleSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var firstRowTxt = Text(
      "Oeschinen Lake Campground",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
    var secondRowTxt = Text(
      "Kandersteg, Switzerland",
      style: TextStyle(color: Colors.grey[500]),
    );
    var iconView = Icon(
      Icons.star,
      color: Colors.red[500],
    );
    var countTxt = Text(
      "41",
    );

    var column = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 8),
          child: firstRowTxt,
        ),
        secondRowTxt
      ],
    );
    var row = Row(
      children: <Widget>[
        Expanded(
          child: column,
        ),
        iconView,
        countTxt
      ],
    );
    var container = Container(
      padding: const EdgeInsets.all(32),
      child: row,
    );

    return container;
  }
}

class IndustryRowView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Color titleColor = Color(0xff5d5d5d);

    var rowView = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            onTap: () {
              //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Tap me!"),));
              // _navigateAndDisplaySelection(context);
             // Navigator.pushNamed(context, "/SocketVC");
              // Navigator.pushNamed(context, "/ScrollChangeLayoutVC");
              Navigator.pushNamed(context, "/MallProductDetail");
            },
            child: ButtonItemView("家电", "images/home/jiadian.png", titleColor),
          ),
          InkWell(
            onTap: () {
              // Scaffold.of(context).showSnackBar(SnackBar(content: Text("I am Rout menu")));
              Navigator.pushNamed(context, "/ImagePickerVC");
            },
            child: ButtonItemView("相机", "images/home/shouji.png", titleColor),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/SqliteVC");
            },
            child: ButtonItemView("Sql", "images/home/shuma.png", titleColor),
          ),
          InkWell(
            onTap: () {
              // Navigator.pushNamed(context, "/RecordVC");

              Navigator.pushNamed(context, "/WxHomeVc");
            },
            child: ButtonItemView("wx", "images/home/diannao.png", titleColor),
          ),
          InkWell(
              onTap: () {
                // Scaffold.of(context).showSnackBar(SnackBar(content: Text("I am Rout menu")));
                Navigator.pushNamed(context, "/PlayVideo");
              },
              child: ButtonItemView(
                "播视",
                "images/home/jiaju.png",
                titleColor,
              )),
        ]);

    return Container(
      color: Colors.white,
      child: rowView,
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      // We'll create the SelectionScreen in the next step!
      MaterialPageRoute(builder: (context) => SelectionScreen()),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result!
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }
}

class ButtonItemView extends StatelessWidget {
  String title;
  String icon;
  Color titleColor;
  ButtonItemView(this.title, this.icon, this.titleColor);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var titleLbl = Text(
      this.title,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 12, color: titleColor),
    );
    //var iconView = Icon(icon, color: titleColor,);

    var iconView = Image.asset(
      this.icon,
      width: 25,
      height: 22,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 29),
          child: iconView,
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 9, 0, 13),
          child: titleLbl,
        )
      ],
    );
  }
}

class SectionItemView extends StatelessWidget {
  HomeRecTitleItem item;

  SectionItemView(
    this.item,
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var titleLbl = Text(
      this.item.industryName,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
    );
    var moreLbl = Text(
      "查看更多",
      style: TextStyle(fontSize: 12, color: Color(0xff666666)),
    );

    var iconView = Image.asset(
      "images/home/jiantou.png",
      width: 5,
      height: 8,
    );

    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 8),
            child: titleLbl,
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(0, 8, 8, 0),
          child: this.item.hideMore == false ? moreLbl : Container(),
        ),
        Container(
          margin: EdgeInsets.only(top: 8),
          child: this.item.hideMore == false ? iconView : Container(),
        ),
      ]),
      height: 45,
      color: Color(0xfff3f8f9),
    );
  }
}

class BrandItemView extends StatelessWidget {
  HomeBrandDataItem dataItem;

  BrandItemView(
    this.dataItem,
  );

  testSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed 1 $counter times.');
    await prefs.setInt('counter', counter);

    counter = (prefs.getInt('counter') ?? 0) + 1;
    print('Pressed 2 $counter times.');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var titleLbl = Text(
      this.dataItem.brandName + "品牌服务商",
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
    );

//    var logoView = Image.asset("images/lake.jpg", width: 80, height: 80,fit: BoxFit.fitWidth,);

    var logoView = CachedNetworkImage(
      imageUrl: dataItem.logo,
      //"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=77d1cd475d43fbf2da2ca023807fca1e/9825bc315c6034a8ef5250cec5134954082376c9.jpg",
      placeholder: (context, url) => new CircularProgressIndicator(),
      errorWidget: (context, url, error) => new Icon(Icons.error),
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.fill,
    );

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(children: <Widget>[
        Container(
          color: Color(0xfff3f8f9),
          width: MediaQuery.of(context).size.width,
          height: 10,
        ),
        Container(
          padding: EdgeInsets.all(0),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: logoView,
                width: 110,
              ),
              new Container(
                  width: 1,
                  height: 80,
                  color: Color(0xfff3f8f9),
                  margin: EdgeInsets.fromLTRB(1, 0, 0, 0)),
              Expanded(
                  child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 18, 0, 0),
                    child: titleLbl,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new GestureDetector(
                        onTap: () {
                          testSharedPreference();
                          // Navigator.pushNamed(context, "/loadmore");
                          Navigator.pushNamed(context, "/DemoHomePage");

                          // Scaffold.of(context).showSnackBar(SnackBar(content: Text("在线客服")));
                        },
                        child: BrandMenuItemView(
                            "在线客服", "images/home/jiaju.png", Color(0xff999999)),
                      ),
                      new GestureDetector(
                          onTap: () {
                            // Scaffold.of(context).showSnackBar(SnackBar(content: Text("服务大厅")));
                            pushToLoginVC(context);
                          },
                          child: BrandMenuItemView("服务大厅",
                              "images/home/jiaju.png", Color(0xff999999))),
                      new GestureDetector(
                          onTap: () {
                            // Navigator.pushNamed(context, "/animation");
                            Navigator.pushNamed(context, "/MallVC", arguments: dataItem);



                            //Scaffold.of(context).showSnackBar(SnackBar(content: Text("官网商场")));
                          },
                          child: BrandMenuItemView("官网商城",
                              "images/home/jiaju.png", Color(0xff999999)))
                    ],
                  )
                ],
              )),
            ],
          ),
        ),
      ]),
      height: 130,
      color: Color(0xffffffff),
    );
  }

  pushToLoginVC(BuildContext context) async {
    final result = await Navigator.pushNamed(context, "/login");
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }
}

class BrandMenuItemView extends StatelessWidget {
  String title;
  String icon;
  Color titleColor;
  BrandMenuItemView(this.title, this.icon, this.titleColor);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var titleLbl = Text(
      this.title,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 12, color: titleColor),
    );
    //var iconView = Icon(icon, color: titleColor,);

    var iconView = Image.asset(
      this.icon,
      width: 15,
      height: 15,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 26),
          child: iconView,
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 6, 0, 18),
          child: titleLbl,
        )
      ],
    );
  }
}

class RecommandBrandView extends StatelessWidget {
  HomeRecItem recItem;

  RecommandBrandView(this.recItem);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var itemMargin = 5;
    var totalHeight = 65.0;
    final gridView = GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this would produce 2 rows.
      crossAxisCount: 5,
      crossAxisSpacing: 5,
      // mainAxisSpacing: 0,
      // childAspectRatio: 2.3 / 1,
      physics: new NeverScrollableScrollPhysics(),
      // Generate 100 Widgets that display their index in the List
      children: List.generate(recItem.brandList.length, (index) {
        return Container(
          padding: EdgeInsets.all(16),
          color: Colors.white,
          child: Center(
            child: CachedNetworkImage(
              imageUrl: recItem.brandList[index].logo,
              //"https://ss1.baidu.com/9vo3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=77d1cd475d43fbf2da2ca023807fca1e/9825bc315c6034a8ef5250cec5134954082376c9.jpg",
              errorWidget: (context, url, error) => new Icon(Icons.error),
              fit: BoxFit.fill,
            ),
          ),
        );
      }),
    );

    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      height: totalHeight,
      child: gridView,
      color: Color(0xfff3f8f9),
      // color: Colors.black,
    );
  }
}

class BrandModel {
  BrandModel(this.brandName);
  String brandName;
}

class SelectionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: Text('Pick an option, any option!'),
    );
  }

  // A method that launches the SelectionScreen and awaits the result from
  // Navigator.pop
  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the Selection Screen!
    final result = await Navigator.push(
      context,
      // We'll create the SelectionScreen in the next step!
      MaterialPageRoute(builder: (context) => SelectionScreen()),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result!
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }
}

//MARK:导航栏 
class HomeNavBarView extends PreferredSize {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var logoImg = Image.asset("images/home/logo.png");
    var logoview = Container(
      child: logoImg,
      margin: EdgeInsets.only(left: 10),
    );
    var searchContainer = Container(
      height: 35,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/home/fangdajing.png"),
            Container(
              child: Text(
                "品牌名称",
                style: TextStyle(color: Colors.blue),
              ),
              margin: EdgeInsets.only(left: 8),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue.withAlpha(100), width: 0.5),
        borderRadius: BorderRadius.all(Radius.circular(17.5)),
        boxShadow: [
         // BoxShadow(offset: Offset(0,0), blurRadius: 2,spreadRadius: 0)
        ]
      ),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
    );
      
   var navView = SafeArea(
      top: true,
      child: 
       Container(
        child: Row(
          children: <Widget>[
            logoview,
            Flexible(
              child: searchContainer,
            )
          ],
        ),
        height: 80,
      ) 
    ); 
 
    final AppBarTheme appBarTheme = AppBarTheme.of(context); 
    final Brightness brightness = appBarTheme.brightness; 
    final SystemUiOverlayStyle overlayStyle = brightness == Brightness.dark
      ? SystemUiOverlayStyle.light
      : SystemUiOverlayStyle.dark;

    return Semantics(
      container: true,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Material(
          color: appBarTheme.color,
          elevation: 0,
          // shape: widget.shape,
          child: Semantics(
            explicitChildNodes: true,
            child: navView,
          ),
        ),
      ),
    );

    //============
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => AppBar().preferredSize;
}
