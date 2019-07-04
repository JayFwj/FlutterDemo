import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MeScreenState();
  }
}

class _MeScreenState extends State<MeScreen> {

static const platform = const MethodChannel('samples.flutter.dev/battery');

  // Get battery level.
  String _batteryLevel = 'Unknown battery level.';

  Widget temp = Container(color: Colors.black, width: 100, height: 200,);

Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      temp  = await platform.invokeMethod('getBatteryLevel'); 
    } on PlatformException catch (e) {
      temp = Text("Empty View");
    } 
    setState(() { 
    });
  }

  Future<void> _getBatteryLevel2() async {
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Me Screen"),
      ),
      body: Center(
        child: temp,
      ),
      floatingActionButton: FlatButton(child: Text("Battery"),onPressed: (){
        _getBatteryLevel();
      },),
    );
  }
}