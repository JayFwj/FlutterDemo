import 'package:flutter/material.dart';
import 'FilterView.dart';

class FilterVC extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FilterVCState();
  }
}

class FilterVCState extends State<FilterVC> {

  var showFilter = false;
  String selectedWords;

  void onChanged(String value){
    setState(() {
      this.showFilter = false;
      this.selectedWords = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("FilterView"),
      ),
      body: Container(
        color: Colors.white,
        child: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(child: FlatButton(
              onPressed: () {
                setState(() {
                  showFilter = !showFilter;
                });
              },
              child: Text("Show Filter View", style: TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.center,),
            ),
            width: MediaQuery.of(context).size.width,
            height: 100,
            color: Colors.blue,
            ),
            this.selectedWords != null ? Text(this.selectedWords) : Text("Please select first")
          ],
        ),
        showFilter ? FilterView(lastSelectedWords: this.selectedWords, onChanged: onChanged,) : Container()

      ],
    )),
    );
  }
}
