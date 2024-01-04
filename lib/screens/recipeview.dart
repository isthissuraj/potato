import "package:flutter/material.dart";
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  String url;
  RecipeView({super.key, required this.url});

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  WebViewController controller = WebViewController();

  final TextStyle _AppBarFont = const TextStyle(
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
      fontSize: 32,
      color: Color(0xffc29843));

  @override
  void initState() {
    super.initState();
    WebViewPlatform.instance;
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xfffae9c4))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfffae9c4),
        centerTitle: true,
        title: Text("Potato", style: _AppBarFont),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
