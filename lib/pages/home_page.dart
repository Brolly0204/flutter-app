import 'package:flutter/material.dart';
import 'package:flutter_app/model/home_model.dart';
import 'package:flutter_app/widget/banner_widget.dart';
import 'package:flutter_app/widget/grid_nav_widget.dart';
import 'package:flutter_app/widget/loading_container.dart';
import 'package:flutter_app/widget/local_nav_widget.dart';
import 'package:flutter_app/widget/sales_box_widget.dart';
import 'package:flutter_app/widget/sub_nav_widget.dart';
import '../dao/login_dao.dart';
import '../dao/home_dao.dart';

class HomePage extends StatefulWidget {
  static Config? configModel;
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  double _appBarAlpha = 0;
  static const appBarScrollOffset = 100;
  // final List<String> bannerList = [
  //   "https://dimg04.c-ctrip.com/images/0AM5w12000g3tat1a3DA2.webp",
  //   "https://dimg04.c-ctrip.com/images/0AM2012000g6f7cp7DFCA_Q10.webp",
  //   "https://pic.c-ctrip.com/AssetCatalog/gongge/headImg1.png"
  // ];
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
  GridNav? gridNavModel;
  SalesBox? salesBoxModel;
  HomeModel? result;
  bool _loading = true;

  get _logoutBtn => ElevatedButton(
      onPressed: () {
        LoginDao.logout();
      },
      child: const Text(
        '登出',
      ));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('initState');
    _handlerRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      // appBar: AppBar(
      //   // backgroundColor: Colors.blue,
      //   title: const Text(
      //     '首页',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   actions: [_logoutBtn],
      // ),
      backgroundColor: const Color(0xfff2f2f2),
      body: LoadingContainer(
          isLoading: _loading,
          child: Stack(
            children: [_contentView, _appBar],
          )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  get _appBar => Opacity(
        opacity: _appBarAlpha,
        child: Container(
          height: 80,
          decoration: const BoxDecoration(color: Colors.white),
          child: const Center(
              child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              '首页',
              style: TextStyle(color: Colors.black),
            ),
          )),
        ),
      );

  get _listView => ListView(
        children: [
          BannerWidget(bannerList: bannerList),
          LocalNavWidget(localNavList: localNavList),
          if (gridNavModel != null) GridNavWidget(gridNavModel: gridNavModel!),
          SubNavWidget(subNavList: subNavList),
          if (salesBoxModel != null) SalesBoxWidget(salesBox: salesBoxModel!),
          _logoutBtn,
        ],
      );

  get _contentView => MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: NotificationListener(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification &&
                scrollNotification.depth == 0) {
              _onScroll(scrollNotification.metrics.pixels);
            }
            return false;
          },
          child: _listView));

  void _onScroll(double offset) {
    double alpha = offset / appBarScrollOffset;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _appBarAlpha = alpha;
    });
  }

  void _handlerRefresh() async {
    try {
      HomeModel? model = await HomeDao.fetch();
      setState(() {
        result = model;
        HomePage.configModel = model?.config;
        localNavList = model?.localNavList ?? [];
        subNavList = model?.subNavList ?? [];
        gridNavModel = model?.gridNav;
        salesBoxModel = model?.salesBox;
        bannerList = model?.bannerList ?? [];
        _loading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
