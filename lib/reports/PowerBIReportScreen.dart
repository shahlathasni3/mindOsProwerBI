// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class ReportScreen extends StatefulWidget {
//   @override
//   _ReportScreenState createState() => _ReportScreenState();
// }
//
// class _ReportScreenState extends State<ReportScreen> {
//   late WebViewController _controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Chat Report")),
//       body: WebView(
//         initialUrl: "https://app.powerbi.com/reportEmbed?reportId=aac35aba-c3a4-46ff-98c8-f102486cbee7&autoAuth=true&ctid=a84203e7-39a7-4808-ae0e-b3ae884790d0",
//         javascriptMode: JavascriptMode.unrestricted,
//         onWebViewCreated: (WebViewController webViewController) {
//           _controller = webViewController; // Store the controller
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindos_2/homePage.dart';
import 'package:url_launcher/url_launcher.dart';

class PowerBIReportButton extends StatelessWidget {
  final String url = 'https://app.powerbi.com/reportEmbed?reportId=aac35aba-c3a4-46ff-98c8-f102486cbee7&autoAuth=true&ctid=a84203e7-39a7-4808-ae0e-b3ae884790d0';

  void _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: _launchURL,
          child: Text('Open Power BI Report'),
        ),
        ElevatedButton(
          onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
          },
          child: Text('Back to Home'),
        ),
      ],
    );
  }
}



