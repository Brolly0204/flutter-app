import 'package:flutter/material.dart';

import '../model/home_model.dart';

class GridNavWidget extends StatelessWidget {
  final GridNav gridNavModel;
  const GridNavWidget({super.key, required this.gridNavModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(7, 0, 7, 4),
      child: PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: _gridNavItems(context),
        ),
      ),
    );
  }

  List<Widget> _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    items.add(_gridNavItem(context, gridNavModel.hotel!, true));
    items.add(_gridNavItem(context, gridNavModel.flight!, false));
    items.add(_gridNavItem(context, gridNavModel.travel!, false));
    return items;
  }

  Widget _gridNavItem(BuildContext context, Hotel gridNavItem, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem!));
    items.add(_doubleItem(context, gridNavItem.item1!, gridNavItem.item2!));
    items.add(_doubleItem(context, gridNavItem.item3!, gridNavItem.item4!));
    List<Widget> expandItems = [];
    Color startColor = Color(int.parse('0xff${gridNavItem.startColor}'));
    Color endColor = Color(int.parse('0xff${gridNavItem.endColor}'));
    for (var item in items) {
      expandItems.add(Expanded(flex: 1, child: item));
    }
    return Container(
      height: 88,
      margin: first ? null : const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(
        children: expandItems,
      ),
    );
  }

  Widget _mainItem(BuildContext context, CommonModel mainItem) {
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Image.network(
              mainItem.icon!,
              fit: BoxFit.contain,
              width: 61,
              height: 88,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              margin: const EdgeInsets.only(top: 11),
              child: Text(
                mainItem.title!,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
          ],
        ),
        mainItem);
  }

  Widget _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: () {},
      child: widget,
    );
  }

  Widget _doubleItem(
      BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: [
        Expanded(child: _item(context, topItem, true)),
        Expanded(child: _item(context, bottomItem, false)),
      ],
    );
  }

  _item(BuildContext context, CommonModel topItem, bool first) {
    BorderSide borderSide = const BorderSide(width: 0.8, color: Colors.white);
    return Container(
      decoration: BoxDecoration(
          border: Border(
              left: borderSide, bottom: first ? borderSide : BorderSide.none)),
      child: _wrapGesture(
          context,
          Center(
            child: Text(
              topItem.title!,
              style: const TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          topItem),
    );
  }
}
