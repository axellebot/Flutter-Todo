import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/TodoItemModel.dart';

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value. The text is displayed in bright green if selected is true.
/// This widget's height is based on the animation parameter, it varies
/// from 0 to 128 as ther animation varies from 0.0 to 1.0.

class TodoItemCell extends StatefulWidget {
  final DismissDirectionCallback onDelete;
  final TodoItemModel item;

  TodoItemCell({Key key, this.onDelete, @required this.item})
      : assert(item != null),
        super(key: key);

  @override
  _TodotemCellState createState() => new _TodotemCellState();
}

class _TodotemCellState extends State<TodoItemCell> {
  @override
  void initState() {
    super.initState();
  }

  void _onItemCheckChanged(bool value) {
    setState(() {
      widget.item.done = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    TextStyle completedTaskStyle = new TextStyle(
      decoration: new TextDecoration.combine([
        TextDecoration.lineThrough,
      ]),
    );

    return new Dismissible(
        key: new ObjectKey(widget.item),
        direction: DismissDirection.startToEnd,
        onDismissed: widget.onDelete,
        background: new Container(
            color: theme.primaryColor,
            child: const ListTile(
                leading: const Icon(Icons.delete_forever,
                    color: Colors.white, size: 24.0))),
        child: new Container(
            decoration: new BoxDecoration(
                color: theme.canvasColor,
                border: new Border(
                    bottom: new BorderSide(color: theme.dividerColor))),
            child: new CheckboxListTile(
              title: new Text(widget.item.name,
                  style: widget.item.done ? completedTaskStyle : null),
              subtitle: new Text(widget.item.notes,
                  style: widget.item.done ? completedTaskStyle : null),
              onChanged: _onItemCheckChanged,
              value: widget.item.done,
            )));
  }
}
