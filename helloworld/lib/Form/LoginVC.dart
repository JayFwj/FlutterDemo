import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './CustomField.dart';
 

class LoginVC extends StatefulWidget { 
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginVCState();
  }
}
class LoginVCState extends State<LoginVC> { 

  final nameKey = "uname";
  final pwdKey = "upwd"; 
  TextEditingController nameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  CustomField nameField = CustomField("请输入你的用户名", false);
  CustomField pwdField = CustomField("请输入密码", true);
   
   @override
  void initState() {
    // TODO: implement initState
    super.initState(); 
    _loadLastInfo();
  } 
  @override
  Widget build(BuildContext context) {   
    return Scaffold(
      appBar: AppBar(
        title: Text('TextField'),
      ),
      body:
      Container(
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child:  Column(
        children: <Widget>[
          nameField,
          pwdField, 
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(0),
            height: 40,
            color: Colors.blue,
            width: MediaQuery.of(context).size.width - 40,
            child: 
          RaisedButton(color: Colors.orange, onPressed: (){
            _saveLoginInfo(context);
           // Scaffold.of(context).showSnackBar(SnackBar(content: Text("Keey successfully"),));

          },child: Text("登录", style: TextStyle(color: Colors.white),),),)],

      ))
    );
  }

  _loadLastInfo() async {
    SharedPreferences shared = await SharedPreferences.getInstance(); 
    nameField.controller.text = shared.getString(nameKey) ?? "";
    pwdField.controller.text = shared.getString(pwdKey) ?? "";
  } 

  _saveLoginInfo(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = nameField.controller.text;
    String pwd = pwdField.controller.text;
    print('name 2 $name .');
    print('pwd 2 $pwd .');

    Navigator.pop(context,name);

    prefs.setString(nameKey, name);
    prefs.setString(pwdKey, pwd);
  }

}


class LoginVC2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, we want to show a Snackbar
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
