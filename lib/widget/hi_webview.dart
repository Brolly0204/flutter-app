import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/util/navigator_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HiWebView extends StatefulWidget {
  final String? url;
  final String? title;
  final String? statusBarColor;
  final bool? hideAppBar;
  final Function? onPageFinished;
  final bool backForbid = false;
  const HiWebView(
      {super.key,
      this.url,
      this.title,
      this.statusBarColor,
      this.hideAppBar,
      this.onPageFinished});

  @override
  State<HiWebView> createState() => _HiWebViewState();
}

class _HiWebViewState extends State<HiWebView> {
  late WebViewController controller;
  late final Function? _onPageFinished;

  ///主页代表的url
  final _catchUrls = [
    'm.ctrip.com/',
    'm.ctrip.com/html5/',
    'm.ctrip.com/html5'
  ];
  String? url;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = widget.url;
    if (url != null && url!.contains('ctrip')) {
      url = url!.replaceAll('http://', 'https://');
    }
    // if (widget.onPageFinished != null ?? false) {
    //   _onPageFinished = widget.onPageFinished!;
    // }

    _initWebViewController();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) async {
          debugPrint('didpop ${didPop.toString()}');
          if (didPop) {
            return;
          }
          if (await controller.canGoBack()) {
            debugPrint('back1');
            controller.goBack();
          } else {
            // SystemNavigator.pop();
            if (context.mounted) {
              debugPrint('back2');
              NavigatorUtil.pop(context);
            }
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              _appBar(
                  Color(int.parse('0xff$statusBarColorStr')), backButtonColor),
              Expanded(
                  child: WebViewWidget(
                controller: controller,
              ))
            ],
          ),
        ));
  }

  void _initWebViewController() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            // debugPrint('progress:$progress');
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            _handleBackForbid();

            if (widget.onPageFinished != null) {
              widget.onPageFinished!();
            }
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (isMainTo(request.url)) {
              debugPrint('阻止跳转到 $request}');
              NavigatorUtil.pop(context);
              return NavigationDecision.prevent;
            }
            debugPrint('允许跳转到 $request}');
            return NavigationDecision.navigate;
          }))
      ..loadRequest(Uri.parse(url!));
  }

  bool isMainTo(String url) {
    bool contain = false;
    for (final value in _catchUrls) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    double top = MediaQuery.of(context).padding.top;
    debugPrint('top $top');
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: top,
      );
    }
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.fromLTRB(0, top, 0, 10),
      decoration: BoxDecoration(
          color: backgroundColor,
          border: const Border(
              bottom: BorderSide(
                  width: 0.8, color: Color.fromRGBO(28, 31, 33, .1)))),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [_backButton(backButtonColor), _title(backButtonColor)],
        ),
      ),
    );
  }

  _backButton(Color backButtonColor) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Icon(
          Icons.close,
          color: backButtonColor,
          size: 26,
        ),
      ),
    );
  }

  _title(Color backButtonColor) {
    return Positioned(
        left: 0,
        right: 0,
        child: Center(
          child: Text(
            widget.title ?? "",
            style: TextStyle(color: backButtonColor, fontSize: 20),
          ),
        ));
  }

  void _handleBackForbid() {
    const jsStr =
        "var element = document.querySelector('.animationComponent.rn-view'); element.style.display = 'none';";
    if (widget.backForbid ?? false) {
      controller.runJavaScript(jsStr);
    }
  }
}
