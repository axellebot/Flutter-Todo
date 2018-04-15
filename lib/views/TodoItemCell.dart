import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/TodoItemModel.dart';

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value. The text is displayed in bright green if selected is true.
/// This widget's height is based on the animation parameter, it varies
/// from 0 to 128 as ther animation varies from 0.0 to 1.0.

class TodoItemCell extends StatefulWidget {
  final Animation<double> animation;
  final VoidCallback onTap;
  final TodoItemModel item;
  final bool selected;

  TodoItemCell(
      {Key key,
      @required this.animation,
      this.onTap,
      @required this.item,
      this.selected: false})
      : assert(animation != null),
        assert(item != null),
        assert(selected != null),
        super(key: key);

  @override
  _TodotemCellState createState() => new _TodotemCellState();
}

class _TodotemCellState extends State<TodoItemCell> {
  bool _highlight = false;

  @override
  void initState() {
    super.initState();
  }

  void _handleTap() {
    widget.onTap();
  }

  void _onItemCheckChanged(bool value) {
    setState(() {
      widget.item.done = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new SizeTransition(
        axis: Axis.vertical,
        sizeFactor: widget.animation,
        child: new SizedBox(child: _buildCell()));
  }

  Widget _buildCell() {
    TextStyle textStyleBold = new TextStyle(fontWeight: FontWeight.bold);
    TextStyle textStyleRegular = new TextStyle(fontWeight: FontWeight.normal);
    return new Container(
      color: _highlight ? Theme.of(context).accentColor : Colors.white70,
      child: new InkWell(
        onTap: _handleTap,
        child: new Padding(
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: new Row(children: <Widget>[
            new Checkbox(
                value: widget.item.done, onChanged: _onItemCheckChanged),
            new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text("${widget.item.name}", style: textStyleBold),
                  new Text("${widget.item.notes}", style: textStyleRegular)
                ]),
          ]),
        ),
      ),
    );
  }
}
