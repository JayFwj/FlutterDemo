import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import './Book.dart';

enum ActionItemStyle {defaultStyle, destructStyle}

class SqliteVC extends StatelessWidget{

  BookSqlite bookSqlite = new BookSqlite();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(appBar: 
    AppBar(title: Text("Sqlite"), 
            actions: <Widget>[
              InkWell(
                onTap: (){
                  showPickImageActionSheet(context);
                },
                child: Container(child: Center(child: Text("操作"),), margin: EdgeInsets.only(right: 20),),
              )
            ],),
        body: Text("data"), );
  }

  //Sqlit Start
  insertDatas() async{
    await bookSqlite.openSqlite();
    await bookSqlite.insert(new Book(0,"flutter大全0","flutter",0.1,"中国出版"));
    await bookSqlite.insert(new Book(1,"flutter大全1","flutter",0.1,"中国出版"));
    await bookSqlite.insert(new Book(2,"flutter大全2","flutter",0.1,"中国出版"));
    await bookSqlite.insert(new Book(3,"flutter大全3","flutter",0.1,"中国出版"));
    //切记用完就close
    await bookSqlite.close();
  }

   //获取编号为1的书
  void getBookName() async{
    await bookSqlite.openSqlite();
    Book book = await bookSqlite.getBook(1);
    await bookSqlite.close();
    print("book.name = " + book.name);
}

  //Sqlite End


  //选择的对话框
  showPickImageActionSheet(BuildContext context){ 

    Widget actionItem(String title, bool showBottomLine, ActionItemStyle style){
      return Container(
        height: 50,
        child: Column(
          children: <Widget>[
            Expanded(child: Center(child:Text(title, style: TextStyle(color: style==ActionItemStyle.defaultStyle?Colors.black:Colors.red),)),) ,
            Container(height: showBottomLine ? 1 : 0, color: Colors.grey,
            )]
            ,

        ),
      );
    }

    //弹出操作的对话框
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context){
        return new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: (){
                insertDatas();
                Navigator.pop(context);
              },
              child: actionItem("添加", true, ActionItemStyle.defaultStyle),
            ),

            InkWell(
              onTap: (){

                Navigator.pop(context);
              },
              child: actionItem("修改", true, ActionItemStyle.defaultStyle),
            ),

            InkWell(
              onTap: (){

                Navigator.pop(context);
              },
              child: actionItem("删除", true, ActionItemStyle.defaultStyle),
            ),
             InkWell(
              onTap: (){
                getBookName();
                Navigator.pop(context);
              },
              child: actionItem("查询", true, ActionItemStyle.defaultStyle),
            ) ,

            InkWell(
              onTap: (){

                Navigator.pop(context);
              },
              child: Container(child: actionItem("取消", false, ActionItemStyle.destructStyle), margin: EdgeInsets.only(top: 0),),
            ) 
          ],
        );
      }
    );
  }
}