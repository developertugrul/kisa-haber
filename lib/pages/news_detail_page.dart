import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatelessWidget {
  final String url;

  const NewsDetailPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Haber Detay'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
