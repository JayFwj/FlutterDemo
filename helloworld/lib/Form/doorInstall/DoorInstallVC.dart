import 'package:Flutter/Form/addrManage/AddrManageListVC.dart';
import 'package:Flutter/Form/addrManage/AddrModel.dart';
import 'package:Flutter/Form/dialog/DIDateDialogView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';


import 'DIBasicFormView.dart';
import 'DIBasicInfoItem.dart';
import 'DIBasicNavView.dart';

class DoorInstallVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DoorInstallVCState();
  }
}

// DIBasicAddrItemView DIBasicTitleItem  DIBasicInfoItem

class _DoorInstallVCState extends State<DoorInstallVC> {

  ScrollController scrollController = ScrollController();

  DIWeekModel currentDateModel;
  int insuranceIndex = 0;
  String insuranceStr;
  List<String> insuranceList = ["保修中","已过期"]; 
  BasicAddressModel lastSelectedAddrModel;
  DIBasicQuesItem basicQuesItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    basicQuesItem = DIBasicQuesItem();
    scrollController.addListener((){
      //  basicQuesItem.unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var data = EasyLocalizationProvider.of(context).data;

    var code = Localizations.localeOf(context).languageCode;
    print("code = $code");

    var selectTimeView = DIDateDialogView(
        this.cancelCallback,
        this.confirmCallback,
        this.currentDateModel != null ? this.currentDateModel.timeIndex : 0,
        this.currentDateModel != null ? this.currentDateModel.dateIndex : 0);

    ListView listView = ListView(
      controller: scrollController,
      children: <Widget>[
        DIBasicHeaderView(AppLocalizations.of(context).tr('doorRepair')),
        DIBasicTitleItem(AppLocalizations.of(context).tr('basicInfo')),
        InkWell(
          child: DIBasicInfoItem("产品类型", "选择产品类型", true),
          onTap: () {
            setState(() {
              data.changeLocale(Locale('zh', 'CN'));
            });
          },
        ),
        InkWell(
          child: DIBasicInfoItem("产品分类", "选择产品分类", true),
          onTap: () {
             setState(() {
              data.changeLocale(Locale('en', 'US'));
            });
          },
        ),
        InkWell(
          child: DIBasicInfoItem("保修状态", insuranceStr == null ? "选择保修状态" : insuranceStr, true),
          onTap: () {
  
            final picker = Theme(child: CupertinoPicker(
              backgroundColor: Colors.white,
                itemExtent: 40,
                onSelectedItemChanged: (position) {
                  insuranceIndex = position;
                },
                children: [
                  pickItemView("保修中"),
                  pickItemView("已过期"),
                ]),
                data: ThemeData(
                  hintColor: Colors.orange
                ),
                );

            showCupertinoModalPopup(
                context: context,
                builder: (cxt) {
                  return Container(
                    height: 244,
                    child: Column(children: <Widget>[
                      pickerViewTopItem(cxt),
                      Container(child: picker, height: 200,)
                    ],),
                  );
                });

          },
        ),
        basicQuesItem,
        InkWell(
          child: DIBasicInfoItem(
              "期望服务时间",
              this.currentDateModel != null
                  ? this.currentDateModel.formatStr()
                  : "",
              true),
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return selectTimeView;
                });
          },
        ),
        DIBasicTitleItem("服务地址"),
        InkWell(child:DIBasicAddrItemView(this.lastSelectedAddrModel) ,
        onTap: (){
          addrManageAction();
        },),

      ],
    );

    return Scaffold(
      appBar: DIBasicNavView(),
      body: Stack(
        children: <Widget>[
          InkWell(child: listView, onTap: (){
            basicQuesItem.unfocus();
          },)

        ],
      ),
    );
  }

  addrManageAction() async {
    // this.lastSelectedAddrModel = await Navigator.of(context).pushNamed("/AddrManageListVC",
    //       arguments: this.lastSelectedAddrModel);

      this.lastSelectedAddrModel = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddrManageListVC()),
    );
    setState(() {});
  }

  //MAKR:Callback
  cancelCallback() {
    Navigator.pop(context);
  }

  confirmCallback(DIWeekModel model) {
    print(model.date + "==" + model.time);
    currentDateModel = model;
    this.cancelCallback();
    setState(() {});
  }

  //Views
  Widget pickItemView(String title){
    return Container(child: Center(child: Text(title, style: TextStyle(fontSize: 16),)), height: 40,);
  }

  Widget pickerViewTopItem(BuildContext ctx){
    var menuView = Container(
      color: Colors.white,
      child: Row(
      children: <Widget>[
        GestureDetector(child: Container(
          margin: EdgeInsets.only(left: 12),
        child: 
        Text("取消", style: TextStyle(fontSize: 16,color: Color(0xff139ef6), 
        fontWeight: FontWeight.normal),),),
        onTap: (){
            Navigator.pop(ctx);
        }),

        Expanded(child: Container(),),

        GestureDetector(child: Container(
          margin: EdgeInsets.only(right: 12),
          child: 
        Text("确定", style: TextStyle(fontSize: 16,color: Color(0xff139ef6), 
        fontWeight: FontWeight.normal),),),
        onTap: (){
          insuranceStr = insuranceList[insuranceIndex];
          setState(() {});
          Navigator.pop(ctx);
            
        })
      ],
    ),
     height: 43,);

     return Container(child: 
     Column(children: <Widget>[
       menuView, 
       Container(color: Color(0xffcecece),height: 1,)
     ],)
     ,);
  }

}
