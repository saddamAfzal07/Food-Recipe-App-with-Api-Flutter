import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Recipedetails extends StatefulWidget {
  String url;
  Recipedetails(this.url);

  @override
  _RecipedetailsState createState() => _RecipedetailsState();
}

class _RecipedetailsState extends State<Recipedetails> {
  String? Finalurl;
  final Completer<WebViewController> controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    if (widget.url.toString().contains("http://")) {
      Finalurl = widget.url.toString().replaceAll("http://", "https://");
    } else {
      Finalurl = widget.url;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe Details"),
      ),
      body: Container(
        child: WebView(
          initialUrl: Finalurl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController WebViewController) {
            setState(() {
              controller.complete(WebViewController);
            });
          },
        ),
      ),
    );
  }
}
