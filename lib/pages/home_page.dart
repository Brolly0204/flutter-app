import 'package:flutter/material.dart';
import 'package:flutter_app/widget/banner_widget.dart';
import '../dao/login_dao.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  get _logoutBtn => TextButton(
      onPressed: () {
        LoginDao.logout();
      },
      child: const Text(
        '登出',
        style: TextStyle(color: Colors.white),
      ));

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final List<String> bannerList = [
      "https://dimg04.c-ctrip.com/images/0AM5w12000g3tat1a3DA2.webp",
      "https://dimg04.c-ctrip.com/images/0AM2012000g6f7cp7DFCA_Q10.webp",
      "https://pic.c-ctrip.com/AssetCatalog/gongge/headImg1.png"
    ];
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blue,
        title: const Text(
          '首页',
          style: TextStyle(color: Colors.white),
        ),
        actions: [_logoutBtn],
      ),
      body: Column(
        children: [BannerWidget(bannerList: bannerList)],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
