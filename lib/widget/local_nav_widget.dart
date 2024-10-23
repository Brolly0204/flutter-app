import 'package:flutter/material.dart';
import 'package:flutter_app/model/home_model.dart';
import 'package:flutter_app/util/navigator_util.dart';

class LocalNavWidget extends StatelessWidget {
  final List<CommonModel> localNavList;
  const LocalNavWidget({super.key, required this.localNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: const EdgeInsets.fromLTRB(7, 4, 7, 4),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(),
      ),
    );
  }

  Widget _items() {
    List<Widget> widgets = [];
    for (var item in localNavList) {
      widgets.add(_item(item));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widgets,
    );
    // return widgets;
  }

  Widget _item(CommonModel item) {
    return GestureDetector(
      onTap: () {
        debugPrint(item.url);
        NavigatorUtil.jumpH5(url: item.url!, title: '详情');
      },
      child: Column(
        children: [
          Image.network(item.icon!, width: 32, height: 32),
          Text(
            item.title!,
            style: const TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
