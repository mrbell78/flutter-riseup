import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class WebViewClass extends StatefulWidget {


  @override
  _WeViewClassState createState() => _WeViewClassState();
}

class _WeViewClassState extends State<WebViewClass> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: Text("SAM Online",style: TextStyle(color: Colors.white),),),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:'https://rultest2.com/sam/module2-draft-3/',
        onPageFinished: (some) async {},
        onWebViewCreated: (controller) async {
          controller.clearCache();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}
