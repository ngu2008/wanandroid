import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  String title;
  String url;


  WebViewPage({
    Key key,
    @required this.title,
    @required this.url,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new WebViewPageState();
  }
}

class WebViewPageState extends State<WebViewPage> {
  bool isLoad = true;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    // TODO: implement initState
    flutterWebviewPlugin.onStateChanged.listen((state) {
      debugPrint("state:_" + state.type.toString());
      if (state.type == WebViewState.finishLoad) {
        setState(() {
          isLoad = false;
        });
      } else if (state.type == WebViewState.startLoad) {
        setState(() {
          isLoad = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0.4,
        title: new Text(widget.title),
        bottom: new PreferredSize(
            child: isLoad?new LinearProgressIndicator():new Divider(height: 1.0,color: Theme.of(context).primaryColor) ,
            preferredSize: const Size.fromHeight(1.0),
        ),
      ),
      withJavascript: true,
      withZoom: false,
      withLocalStorage: true,
    );
  }
}
