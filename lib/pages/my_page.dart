import 'package:flutter/material.dart';
import 'package:flutter_app/widget/hi_webview.dart';

import '../widget/loading_container.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  bool _loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("我的"),
        ),
        body: LoadingContainer(
          cover: true,
          isLoading: _loading,
          child: HiWebView(
            hideAppBar: true,
            url: 'https://m.imooc.com/',
            onPageFinished: () {
              setState(() {
                _loading = false;
              });
              debugPrint('finis2');
            },
          ),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
