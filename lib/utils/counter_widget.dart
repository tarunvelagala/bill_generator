import 'package:flutter/material.dart';

class CounterItem extends StatefulWidget {
  @override
  _CounterItemState createState() => _CounterItemState();
}

class _CounterItemState extends State<CounterItem> {
  int _itemCount = 0;
  bool isItemAdded = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _itemCount != 0
            ? new IconButton(
                icon: new Icon(Icons.remove),
                onPressed: () => setState(() => _itemCount--),
              )
            : new Container(),
        new Text(_itemCount.toString()),
        new IconButton(
            icon: new Icon(Icons.add),
            onPressed: () => setState(() => _itemCount++))
      ],
    );
  }
}
