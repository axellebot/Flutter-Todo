import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/TodoItemModel.dart';
import 'package:todo/pages/TodoDetailPage.dart';

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value. The text is displayed in bright green if selected is true.
/// This widget's height is based on the animation parameter, it varies
/// from 0 to 128 as ther animation varies from 0.0 to 1.0.

class TodoItemCell extends StatefulWidget {
  final TodoItemModel todoItem;
  final DismissDirectionCallback onDismissed;

  TodoItemCell({Key key, @required this.todoItem, this.onDismissed})
      : assert(todoItem != null),
        super(key: key);

  @override
  _TodotemCellState createState() => new _TodotemCellState();
}

class _TodotemCellState extends State<TodoItemCell> {
  @override
  void initState() {
    super.initState();
  }

  void _handleTap(TodoItemModel todoItem) {
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new TodoDetailPage(
              item: todoItem,
            ),
      ),
    );
  }

  void _onItemCheckChanged(bool value) {
    setState(() {
      widget.todoItem.done = value;
    });
  }

  Widget _buildCell() {
    final ThemeData theme = Theme.of(context);

    TextStyle completedTaskStyle = new TextStyle(
      decoration: new TextDecoration.combine([
        TextDecoration.lineThrough,
      ]),
    );

    return new Dismissible(
      key: new ObjectKey(widget.todoItem),
      direction: DismissDirection.startToEnd,
      onDismissed: widget.onDismissed,
      background: new Container(
        color: theme.primaryColor,
        child: const ListTile(
          leading: const Icon(
            Icons.delete_forever,
            color: Colors.white,
            size: 24.0,
          ),
        ),
      ),
      child: new Container(
        decoration: new BoxDecoration(
          color: theme.canvasColor,
          border: new Border(
            bottom: new BorderSide(
              color: theme.dividerColor,
            ),
          ),
        ),
        child: new ListTile(
          title: new Text(
            widget.todoItem.name,
            style: widget.todoItem.done ? completedTaskStyle : null,
          ),
          subtitle: new Text(
            widget.todoItem.notes,
            style: widget.todoItem.done ? completedTaskStyle : null,
          ),
          trailing: new Checkbox(
            value: widget.todoItem.done,
            onChanged: _onItemCheckChanged,
          ),
          onTap: () => _handleTap(widget.todoItem),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      child: _buildCell(),
    );
  }
}
