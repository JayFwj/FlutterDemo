import 'package:Flutter/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DIDateDialogView extends StatefulWidget {
  VoidCallback cancelCallback;
  ValueChanged<DIWeekModel> confirmCallback;

  int selectedWeekIndex = 0;
  int selectedTimeIndex = 0;

  DIDateDialogView(this.cancelCallback, this.confirmCallback, this.selectedTimeIndex, this.selectedWeekIndex);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DIDateDialogViewState();
  }
}

class _DIDateDialogViewState extends State<DIDateDialogView> {
  

  List<DIWeekModel> dateList = List<DIWeekModel>();
  List<String> timeList = List<String>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateList.add(DIWeekModel("星期一", "明天"));
    dateList.add(DIWeekModel("星期二", "2019.7.14"));
    dateList.add(DIWeekModel("星期三", "2019.7.15"));
    dateList.add(DIWeekModel("星期四", "2019.7.16"));
    dateList.add(DIWeekModel("星期五", "2019.7.17"));
    dateList.add(DIWeekModel("星期六", "2019.7.18"));

    timeList.add("08:00~10:00");
    timeList.add("10:00~12:00");
    timeList.add("12:00~14:00");
    timeList.add("14:00~16:00");
    timeList.add("16:00~18:00");
    timeList.add("18:00~20:00");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var bgView = Container(
      color: Colors.black.withAlpha(170),
    );

    var weekView = ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: dateList.length,
      itemBuilder: (context, index) {
        return InkWell(
          child: dateItem(dateList[index].week, dateList[index].date,
              index == widget.selectedWeekIndex),
          onTap: () {
            widget.selectedWeekIndex = index;
            setState(() {});
          },
        );
      },
    );

    var timeListView = GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 115,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 2.5),
      itemCount: timeList.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          child: timeItem(timeList[index], index == widget.selectedTimeIndex),
          onTap: () {
            widget.selectedTimeIndex = index;
            setState(() {});
          },
        );
      },
    );

    var view = Container(
      color: Colors.white,
      height: 480,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: titleItem("请选择服务日期(可选未来7天)"),
            margin: EdgeInsets.only(left: 10, top: 30),
          ),
          Container(
            child: weekView,
            height: 80,
            margin: EdgeInsets.only(left: 10, top: 15),
          ),
          Container(
            child: titleItem("请选择期望服务时间段"),
            margin: EdgeInsets.only(left: 10, top: 30),
          ),
          Container(
            child: timeListView,
            height: 100,
            margin: EdgeInsets.only(left: 10, top: 15, right: 10),
          ),
          Expanded(
            child: Container(),
          ),
          DIDateBottomView(widget.cancelCallback, confirmCallback),
        ],
      ),
    ); 
  
    return view;
   
  }

  //Action
  confirmCallback(){
    var date = this.dateList[widget.selectedWeekIndex];
    date.time = this.timeList[widget.selectedTimeIndex];
    date.timeIndex = widget.selectedTimeIndex;
    date.dateIndex = widget.selectedWeekIndex;
    widget.confirmCallback(date);
  }

  Widget titleItem(String title) {
    return Text(
      title,
      style: TextStyle(color: Color(0xff666666), fontSize: 14),
    );
  }

  Widget dateItem(String week, String date, bool selected) {
    Color normalWeekColor = Color(0xff666666);
    Color normalDateColor = Color(0xff999999);

    Color sWeekColor = Color(0xff139ef6);
    Color sDateColor = Color(0xff139ef6);

    Color currentColor = selected ? sWeekColor : normalWeekColor;

    Text weekLbl = Text(
      week,
      style: TextStyle(
          color: selected ? sWeekColor : normalWeekColor, fontSize: 14),
    );
    Text dateLbl = Text(
      date,
      style: TextStyle(
          color: selected ? sDateColor : normalDateColor, fontSize: 14),
    );

    Image selectedIconView = Image.asset(R.resourcesImagesFormSanjiaogouPng);

    Container view = Container(
      width: 85,
      height: 85,
      margin: EdgeInsets.only(right: 10),
      child: Stack(
        children: <Widget>[
          Container(
            width: 85,
            height: 85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container( 
                  child: weekLbl,
                  margin: EdgeInsets.only(top: 20),
                ),
                Container(
                  child: dateLbl,
                  margin: EdgeInsets.only(top: 8),
                ),
              ],
            ),
          ),
          selected ? Positioned(child: selectedIconView ,bottom: 0, right: 0,) : Container()
        ],
      ),
      decoration:
          BoxDecoration(border: Border.all(color: currentColor, width: 0.5)),
    );
    return view;
  }

  Widget timeItem(String time, bool selected) {
    Color normalWeekColor = Color(0xff666666);
    Color sWeekColor = Color(0xff139ef6);
    Color currentColor = selected ? sWeekColor : normalWeekColor;
    Text timeLbl = Text(
      time,
      style: TextStyle(color: currentColor, fontSize: 12),
    );

    Image selectedIconView = Image.asset(R.resourcesImagesFormSanjiaogouPng);

    Container view = Container(
      width: 115,
      height: 40,
      child: Align(
        child: timeLbl,
        alignment: FractionalOffset.center,
      ),
    );
    return Container(
      width: 115,
      height: 40,
      child:Stack(children: <Widget>[
        view,
        selected ? Positioned(child: selectedIconView ,bottom: 0, right: 0,) : Container()

    ],),
      decoration:
          BoxDecoration(border: Border.all(color: currentColor, width: 0.5)),
    );
 
  }
}

class DIWeekModel {
  String week;
  String date;
  String time;
  
  int timeIndex;
  int dateIndex;

  DIWeekModel(this.week, this.date);

  String formatStr(){
    return date + " " + this.time;
  }
}

class DIDateBottomView extends StatelessWidget {
  VoidCallback cancelCallback;
  VoidCallback confirmCallback;

  DIDateBottomView(this.cancelCallback, this.confirmCallback);

  @override
  Widget build(BuildContext context) {
    Container container = Container(
      color: Color(0xff139ef6),
      height: 45,
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              child: buttonItem("取消", Color(0xffffffff), Color(0xff139ef6)),
              onTap: () {
                cancelCallback();
              },
            ),
          ),
          Expanded(
            child: InkWell(
              child: buttonItem("确定", Color(0xff23a0f3), Color(0xffffffff)),
              onTap: () {
                confirmCallback();
              },
            ),
          )
        ],
      ),
    );

    return Column(
      children: <Widget>[
        Container(
          color: Color(0xff23a0f3),
          height: 0.5,
        ),
        container
      ],
    );
  }

  Widget buttonItem(String title, Color bgColor, Color txtColor) {
    return Container(
      color: bgColor,
      child: Align(
        child: Text(
          title,
          style: TextStyle(color: txtColor),
        ),
      ),
    );
  }
}
