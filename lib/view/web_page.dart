import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_app/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebPage extends StatefulWidget {
  const WebPage({Key? key}) : super(key: key);
  @override
  State<WebPage> createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> {
  late WebViewController controller; //WebViewを管理するコントローラー
  double progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebPage'),
        actions: [
          IconButton(
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack(); //前のページに戻る
              }
            },
            icon: const Icon(Icons.arrow_back),
          ),
          IconButton(
            onPressed: () {
              controller.reload(); //再描画する
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: progress,
            color: Colors.red,
            backgroundColor: Colors.grey,
          ),
          Expanded(
            child: Consumer(
              builder: ((context, ref, child) {
                final _provider = ref.watch(provider.notifier);
                return WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: _provider.state,
                  onWebViewCreated: (controller) {
                    this.controller = controller; //このWebViewを管理する
                  },
                  onProgress: (progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
