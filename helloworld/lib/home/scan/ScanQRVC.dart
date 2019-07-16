import 'package:Flutter/r.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScanQRVC2 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Image image = Image.asset(R.resourcesImagesLakeJpg, width: 100, height: 100, fit: BoxFit.fill,);

    var clip = ClipRect(child: 
      Align(child: image, alignment: Alignment.topCenter, heightFactor: 0.5,),
      );
 

    var view = Container(color: Colors.orange,child: clip,);

    

    return Scaffold(appBar: AppBar(title: Text("扫描"),),
      body: view
    ,);
  }
}


class ScanQRVC extends StatefulWidget {
  @override
  _ScanQRVCState createState() => new _ScanQRVCState();
}

class _ScanQRVCState extends State<ScanQRVC> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Barcode Scanner Example'),
          ),
          body: new Center(
            child: new Column(
              children: <Widget>[
                new Container(
                  child: new MaterialButton(
                      onPressed: scan, child: new Text("Scan")),
                  padding: const EdgeInsets.all(8.0),
                ),
                new Text(barcode),
              ],
            ),
          )),
    );
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }
}