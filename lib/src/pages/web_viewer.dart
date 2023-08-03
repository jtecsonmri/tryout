import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/route_args.dart';
import '../models/webview_args.dart';

class WebViewerPage extends StatefulWidget {
  final RouteArgs? routeArgs;
  const WebViewerPage({super.key, this.routeArgs});

  @override
  State<WebViewerPage> createState() => _WebViewerPageState();
}

class _WebViewerPageState extends State<WebViewerPage> {
  late final WebViewArgs args;
  late final WebViewController controller;
  static const userAgent = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36';
  var loadingPercentage = 0;
  bool isInit = false;
  @override
  void initState() {
    super.initState();
    args = widget.routeArgs!.extra as WebViewArgs;
    controller = WebViewController()
      ..setUserAgent(userAgent)
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          debugPrint('WebViewController - onPageStarted: $url');         
          // setState(() {
          //   loadingPercentage = 0;
          // });
          if(!isInit){
            final items = _getFragmentParams();
            if(items.containsKey('id_token')) {
              controller.runJavaScript("window.localStorage.setItem('id_token','${items['id_token'] ?? ''}')");
              controller.loadRequest(Uri.parse(args.initialUrl!));
              isInit = true;
            }
            if(items.containsKey('access_token')) {
              controller.runJavaScript("window.localStorage.setItem('access_token','${items['access_token'] ?? ''}')");
            }            
          }          
        },
        onProgress: (progress) {
          debugPrint('WebViewController - onProgress: $progress');         
          // setState(() {
          //   loadingPercentage = progress;
          // });
        },
        onPageFinished: (url) {
          debugPrint('WebViewController - onPageFinished: $url');
          // setState(() {
          //   loadingPercentage = 100;
          // });
          if(url.contains(args.defaultUrl!)){
            controller.loadRequest(Uri.parse(args.targetUrl!));
          }
        },
        onUrlChange: (change) {
          debugPrint('WebViewController - onUrlChange: ${change.url}');     
        },
        onWebResourceError: (error) {
          debugPrint('WebViewController - onWebResourceError: ${error.description}');            
        },
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    controller.loadRequest(Uri.parse(args.initialUrl!));
    return SafeArea(
      child: WebViewWidget(
        controller: controller,
      ),
    );
  }

  Map<String,String> _getFragmentParams(){
    Map<String,String> result = {};
    if(widget.routeArgs != null){
      String fragment = widget.routeArgs!.uri.fragment;
      for (final item in fragment.split('&')) {
          final keyVal = item.split('=');
          String key = keyVal[0];
          String val = '';
          if(keyVal.length > 1){
            val = Uri.decodeComponent(keyVal[1]);
          }
          result.putIfAbsent(key,() => val);
      }
    }
    return result;
  }
}