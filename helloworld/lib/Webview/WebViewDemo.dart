import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewDemo extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    // var webView = WebView(initialUrl: "https://wwww.baidu.com",);

    // var webView = FlutterWebviewPlugin();
    // webView.launch("https://www.baidu.com", 
    // rect: Rect.fromLTWH(0, 0, MediaQuery.of(context).size.width, 150),
    // withZoom: true);
    // webView.show();

    // TODO: implement build
    // return Scaffold(appBar: AppBar(title: Text("Webview"),),body: webView,);

    return WebviewScaffold(url: "https://www.baidu.com",withZoom: true,appBar: AppBar(title: Text("Webview"),),);
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

 
// class WebViewDemo extends StatefulWidget {
//   @override
//   _WebViewDemoState createState() => new _WebViewDemoState();
// }

// class _WebViewDemoState extends State<WebViewDemo> {

//   InAppWebViewController webView;
//   String url = "";
//   double progress = 0;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Inline WebView example app'),
//         ),
//         body: Container(
//           child: Column(
//             children: <Widget>[
//               Container(
//                 padding: EdgeInsets.all(20.0),
//                 child: Text("CURRENT URL\n${ (url.length > 50) ? url.substring(0, 50) + "..." : url }"),
//               ),
//               (progress != 1.0) ? LinearProgressIndicator(value: progress) : null,
//               Expanded(
//                 child: Container(
//                   margin: const EdgeInsets.all(10.0),
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.blueAccent)
//                   ),
//                   child: InAppWebView(
//                     initialUrl: "https://flutter.io/",
//                     initialHeaders: {

//                     },
//                     initialOptions: {

//                     },
//                     onWebViewCreated: (InAppWebViewController controller) {
//                       webView = controller;
//                     },
//                     onLoadStart: (InAppWebViewController controller, String url) {
//                       print("started $url");
//                       setState(() {
//                         this.url = url;
//                       });
//                     },
//                     onProgressChanged: (InAppWebViewController controller, int progress) {
//                       setState(() {
//                         this.progress = progress/100;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               ButtonBar(
//                 alignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   RaisedButton(
//                     child: Icon(Icons.arrow_back),
//                     onPressed: () {
//                       if (webView != null) {
//                         webView.goBack();
//                       }
//                     },
//                   ),
//                   RaisedButton(
//                     child: Icon(Icons.arrow_forward),
//                     onPressed: () {
//                       if (webView != null) {
//                         webView.goForward();
//                       }
//                     },
//                   ),
//                   RaisedButton(
//                     child: Icon(Icons.refresh),
//                     onPressed: () {
//                       if (webView != null) {
//                         webView.reload();
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ].where((Object o) => o != null).toList(),
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: 0,
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               title: Text('Home'),
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.mail),
//               title: Text('Item 2'),
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person),
//               title: Text('Item 3')
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

 