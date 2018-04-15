import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/TodoItemModel.dart';
import 'package:todo/views/TodoItemCell.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values
  // provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _TodoListPageState createState() => new _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<TodoItemModel> _list;
  BuildContext context;

  void initList() {
    _list =
        new List<TodoItemModel>.from([new TodoItemModel("Nom 1", "Notes 1")]);
  }

  @override
  void initState() {
    super.initState();
    initList();
  }

  void _handleUndoItem(int index, TodoItemModel item) {
    setState(() {
      _list.insert(index,item);
    });
  }

  void _handleDelete(int index, TodoItemModel item) {
    setState(() {
      _list.remove(item);
    });
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text('You deleted item'),
        action: new SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              _handleUndoItem(index, item);
            })));
  }

  // Used to build list items that haven't been removed.
  List<TodoItemCell> _buildListItems() {
    var items = new List<TodoItemCell>();
    for (var i = 0; i < _list.length; i++) {
      TodoItemModel item = _list[i];
      items.add(TodoItemCell(
        onDelete: (DismissDirection direction) => _handleDelete(i, item),
        item: item,
      ));
    }
    return items;
  }

  // Insert the "next item" into the list model.
  void _create() {
    setState(() {
      final int index = _list.length;
      _list.insert(index,
          new TodoItemModel("Todo Added", "This is a description example"));
    });
  }

  Widget _buildBody(BuildContext context) {
    this.context = context;
    return new ListView(children: _buildListItems());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('Todo List'),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.add),
              onPressed: _create,
              tooltip: 'Create a new Task',
            ),
          ],
        ),
        body: new Builder(builder: _buildBody));
  }
}
