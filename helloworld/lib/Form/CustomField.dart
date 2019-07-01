import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {

  CustomField(this.hintTxt, this.isPassword);

  String hintTxt = "";
  bool isPassword = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
   
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Theme(
          data: ThemeData(primaryColor: Colors.green,  
          hintColor: Colors.green,  ),
          child: 
          TextField(

            controller: controller,
           obscureText: isPassword,
            style: TextStyle(fontSize: 16.0, color: Colors.black), //输入文本的样式
            decoration: InputDecoration(
                hintText: hintTxt,
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0)),
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(2.0),)
                ),
         ),
          ),
      ),
    );
  }
} 
 