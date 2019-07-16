import 'package:Flutter/Form/addrManage/AddrManageListVC.dart';
import 'package:Flutter/Form/doorInstall/DoorInstallVC.dart';
import 'package:Flutter/draw/DrawPractice.dart';
import 'package:Flutter/draw/PathAnimation.dart';
import 'package:Flutter/me/MeVC.dart';
import 'package:Flutter/silver/SilverListVC.dart';
import 'package:Flutter/transform/TransformVC.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Animation/FadeinAnimVC.dart';
import 'Animation/LoadingProgressVC.dart';
import 'HomeVC.dart';
import 'MsgPage.dart';
import '../Form/LoginVC.dart';
import './Animation/AnimatedContainerGroup.dart';
import './LoadMorePage.dart';
import './imagePicker/ImagePickerVC.dart';
import './sqlite/SqliteVC.dart';
import './recordLoc/RecordVC.dart';
import './PlayVideo/PlayVideo.dart';
import '../chat/home/SessionListVC.dart';
import '../chat/moment/WxMomentVc.dart';
import '../chat/Socket/ChatPageVC.dart';
import './touchMove/TouchMoveVC.dart';
import './stack/FilterVC.dart';
import './scrollChangeLayout/ScrollChangeLayoutVC.dart';
import '../plugin/home.dart';

import '../plugin/address_list.dart';
import '../plugin/carousel_demo.dart';
import '../plugin/circle_progress.dart';
import '../plugin/colorful_divider_demo.dart';
import '../plugin/image_upload.dart';
import '../plugin/load_more_gridview.dart';
import '../plugin/load_more_listview.dart';
import '../plugin/rate.dart';
import '../plugin/stepper.dart';
import '../plugin/wave_progress_demo.dart';
import '../Webview/WebViewDemo.dart';
import '../shoppingcart/ShoppingCartVC.dart';

import './mall/MallVC.dart';
import 'mall/detail/MallProductDetail.dart';
import 'scan/ScanQRVC.dart';
 
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     var dataProvider = EasyLocalizationProvider.of(context);
     var data = dataProvider.data;

     var mate = new MaterialApp( 
      localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          //app-specific localization
          EasylocaLizationDelegate(
              locale: data.locale ?? Locale('zh', 'CN'),
              path: 'resources/langs'),
        ],
        supportedLocales: [Locale('en', 'US'),
         Locale('zh', 'CN')
         ],
        locale: data.locale,
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          "/login": (BuildContext context) => new LoginVC(),
          "/animation": (BuildContext context) => new AnimatedContainerApp(),
          "/loadmore": (BuildContext context) => new LoadMorePage(),
          "/ImagePickerVC": (BuildContext context) => new ImagePickerVC(),
          "/SqliteVC": (BuildContext context) => new SqliteVC(),
          "/RecordVC": (BuildContext context) => new RecordVC(),
          "/PlayVideo": (BuildContext context) => new PlayVideo(),
          
        "/SessionListVC": (BuildContext context) => new SessionListVC(),
        "/WxMomentVc": (BuildContext context) => new WxMomentVc(),
        "/SocketVC": (BuildContext context) => new ChatPageVC(),

        "/TouchMoveView": (BuildContext context) => new TouchMoveView(),
        "/FilterVC": (BuildContext context) => new FilterVC(),
        
        "/ScrollChangeLayoutVC": (BuildContext context) => new ScrollChangeLayoutVC(),
        "/DemoHomePage": (BuildContext context) => new DemoHomePage(),

        "/circle_progress_demo": (BuildContext context) => new CircleProgressDemo(),
        "/wave_progress_demo": (BuildContext context) => new WaveProgressDemo(),
        "/colorful_divider_demo": (BuildContext context) => new ColorfulDividerDemo(),
        "/address_edit": (BuildContext context) => new AddressListPage(),
        "/stepper": (BuildContext context) => new MyStepper(),
        "/rate": (BuildContext context) => new RateDemo(),
        "/listview": (BuildContext context) => new LoadMoreListView(),
        "/gridview": (BuildContext context) => new LoadMoreGridView(),
        "/image_uploader": (BuildContext context) => new ImageUpload(),
        "/carousel_demo": (BuildContext context) => new CarouselDemo(),
        "/WebViewDemo": (BuildContext context) => new WebViewDemo(),

        "/ShoppingCartVC": (BuildContext context) => new ShoppingCartVC(),

        "/MallVC": (BuildContext context) => new MallVC(),
        "/MallProductDetail": (BuildContext context) => new MallProductDetail(),
        "/FadeinAnimVC": (BuildContext context) => new FadeinAnimVC(),
        "/LoadingProgressVC": (BuildContext context) => new LoadingProgressVC(),

        "/ScanQRVC": (BuildContext context) => new ScanQRVC(),

        "/DrawPractice": (BuildContext context) => new DrawPractice(),
        "/PathAnimation": (BuildContext context) => new PathAnimation(),

        "/SilverListVC": (BuildContext context) => new SilverListVC(),
        "/TransformVC": (BuildContext context) => new TransformVC(),
        "/DoorInstallVC": (BuildContext context) => new DoorInstallVC(),
        
        "/AddrManageListVC": (BuildContext context) => new AddrManageListVC(),
        
        },
        home: new MainPageWidget());

     
    return EasyLocalizationProvider(
      data: data,
      child:mate
     );
    // return mate;
  }
}

class MainPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MainPageState();
  }
}
class MainPageState extends State<MainPageWidget> {
  int _tabIndex = 0;
  var tabImages;
  var appBarTitles = ['首页', '消息', '购物车', '我的'];

  /*
   * 根据image路径获取图片
   * 这个图片的路径需要在 pubspec.yaml 中去定义
   */
  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  /*
   * 根据索引获得对应的normal或是press的icon
   */
  Image getTabIcon(int curIndex) {
    if (curIndex == _tabIndex) {
      return tabImages[curIndex][1];
    }
    return tabImages[curIndex][0];
  }
  /*
   * 获取bottomTab的颜色和文字
   */
  Text getTabTitle(int curIndex) {
    if (curIndex == _tabIndex) {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(color:  Colors.blue, fontSize: 12));
    } else {
      return new Text(appBarTitles[curIndex],
          style: new TextStyle(color: const Color(0xff888888)));
    }
  }
  /*
   * 存储的四个页面，和Fragment一样
   */

  void initData() {
    /*
      bottom的按压图片
     */
    tabImages = [
      [
        getTabImage('images/home/shouyekong.png'),
        getTabImage('images/home/shouyeshi.png')
      ],
      [
        getTabImage('images/home/xiaoxikong.png'),
        getTabImage('images/home/xiaoxishi.png')
      ],
      [
        getTabImage('images/home/gouwuchekong.png'),
        getTabImage('images/home/gouwucheshi.png')
      ],
      [
        getTabImage('images/home/wodekong.png'),
        getTabImage('images/home/wodeshi.png')
      ]
    ];

    
  }

  @override
  Widget build(BuildContext context) {
    initData();
    // TODO: implement build
    return Scaffold(
      // body: _bodys[_tabIndex],
      body: IndexedStack(children: <Widget>[
        new HomeScreen(),
      new SessionListVC(),
      new ShoppingCartVC(),
      new MeScreen()
      ],index: _tabIndex,),
      bottomNavigationBar: new BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: getTabIcon(0), title: getTabTitle(0)),
          new BottomNavigationBarItem(
              icon: getTabIcon(1), title: getTabTitle(1)),
          new BottomNavigationBarItem(
              icon: getTabIcon(2), title: getTabTitle(2)),
          new BottomNavigationBarItem(
              icon: getTabIcon(3), title: getTabTitle(3)),
        ],
        //设置显示的模式
        type: BottomNavigationBarType.fixed,
        //设置当前的索引
        currentIndex: _tabIndex,
        //tabBottom的点击监听
        onTap: (index) {
          setState(() {
            _tabIndex = index;
          });
        },
      ),
    );
  }
}