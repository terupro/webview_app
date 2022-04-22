import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_app/provider.dart';
import 'package:webview_app/view/web_page.dart';

class InputPage extends ConsumerWidget {
  const InputPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _controller = TextEditingController();
    final _provider = ref.watch(provider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Page'),
        actions: [
          IconButton(
            onPressed: () {
              _controller.text = "";
            },
            icon: const Icon(Icons.autorenew),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onChanged: (value) {
                _provider.state = value;
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_provider.state == "") {
                  showOkAlertDialog(
                    context: context,
                    title: 'URLを入力してください',
                  );
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const WebPage()));
                }
              },
              child: const Text('OPEN WEB'),
            ),
          ],
        ),
      ),
    );
  }
}
