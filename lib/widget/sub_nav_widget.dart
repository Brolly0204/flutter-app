import 'package:flutter/material.dart';
import 'package:flutter_app/model/home_model.dart';

class SubNavWidget extends StatelessWidget {
  final List<CommonModel>? subNavList;
  const SubNavWidget({super.key, required this.subNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 0, 7, 0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  _items(BuildContext context) {
    if (subNavList == null) return null;
    List<Widget> items = [];
    for (var model in subNavList!) {
      items.add(_item(model));
    }

    int seperate = (subNavList!.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, seperate),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(seperate, items.length),
          ),
        )
      ],
    );
  }

  Widget _item(CommonModel model) {
    return Expanded(
      child: GestureDetector(
          child: Column(
        children: [
          Image.network(
            model.icon!,
            width: 18,
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Text(
              model.title!,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      )),
    );
  }
}
