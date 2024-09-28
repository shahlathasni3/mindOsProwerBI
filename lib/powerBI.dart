// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class PowerBIReportView extends StatefulWidget {
//   final String embedUrl;
//   final String embedToken;
//
//   PowerBIReportView({required this.embedUrl, required this.embedToken});
//
//   @override
//   _PowerBIReportViewState createState() => _PowerBIReportViewState();
// }
//
// class _PowerBIReportViewState extends State<PowerBIReportView> {
//   late WebViewController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Power BI Report")),
//       body: WebView(
//         initialUrl: widget.embedUrl,
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           controller = webViewController;
//         },
//         onPageFinished: (String url) async {
//           // You can inject the embed token here if needed
//           String tokenScript = "var models = window['powerbi-client'].models; "
//               "var embedToken = '${widget.embedToken}'; "
//               "// Add more JS logic if needed";
//           controller.runJavaScript(tokenScript);
//         },
//       ),
//     );
//   }
// }
