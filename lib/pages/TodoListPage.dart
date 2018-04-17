import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/TodoItemModel.dart';
import 'package:todo/pages/TodoDetailPage.dart';
import 'package:todo/pages/TodoItemCell.dart';
import 'package:todo/presenters/TodoListPresenter.dart';
import 'package:todo/views/TodoListView.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key key}) : super(key: key);

  @override
  _TodoListPageState createState() => new _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> implements TodoListView {
  List<TodoItemModel> _list;
  TodoListPresenter _presenter;
  BuildContext _scaffoldContext;
  bool _isLoadingTasks;

  _TodoListPageState() {
    _presenter = TodoListPresenter(this);
  }

  @override
  void showLoadingTasksComplete(List<TodoItemModel> items) {
    setState(() {
      _list.clear();
      _list.addAll(items);
      _isLoadingTasks = false;
    });
    Scaffold.of(_scaffoldContext)?.showSnackBar(
          new SnackBar(
            content: const Text('Refresh Succeed'),
          ),
        );
  }

  @override
  void showLoadingTasksError() {
    setState(() {
      _isLoadingTasks = false;
    });
    Scaffold.of(_scaffoldContext)?.showSnackBar(
          new SnackBar(
            content: const Text('Refresh failed'),
            action: new SnackBarAction(
              label: 'RETRY',
              onPressed: _loadTasks,
            ),
          ),
        );
  }

  void _loadTasks() {
    if (_isLoadingTasks) return;
    setState(() {
      _isLoadingTasks = true;
    });
    _presenter.loadTodoList();
  }

  @override
  void initState() {
    super.initState();
    _list = new List<TodoItemModel>();
    _isLoadingTasks = false;
    _loadTasks();
  }

  void _handleUndo(TodoItemModel todoItem) {
    _presenter.saveTodoItem(todoItem);
    setState(() {
      _list.add(todoItem);
    });

    Scaffold.of(_scaffoldContext)?.showSnackBar(
          new SnackBar(
            content: new Text('Undo succeed'),
          ),
        );
  }

  // TODO : Mutual access on list when item delete (cause crash on debug mode)
  void _handleDelete(int index, TodoItemModel todoItem) {
    print(index);
    _presenter.deleteTodoItem(todoItem);
    setState(() {
      _list.remove(todoItem);
    });
    Scaffold.of(_scaffoldContext)?.showSnackBar(
          new SnackBar(
            content: new Text('You deleted an item'),
            action: new SnackBarAction(
              label: 'UNDO',
              onPressed: () {
                _handleUndo(todoItem);
              },
            ),
          ),
        );
  }

  void _createTask() {
    Navigator.push(
      _scaffoldContext,
      new MaterialPageRoute(
        builder: (_scaffoldContext) => new TodoDetailPage(
              item: new TodoItemModel("", ""),
            ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    this._scaffoldContext = context;
    var items = new List<TodoItemCell>();
    for (int index = 0; index < _list.length; index++) {
      TodoItemModel todoItem = _list.elementAt(index);
      items.add(new TodoItemCell(
        todoItem: todoItem,
        onDismissed: (DismissDirection direction) =>
            _handleDelete(index, todoItem),
      ));
    }

    return new ListView(
      children: items,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Todo List'),
        actions: <Widget>[
          new IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTasks,
          ),
        ],
      ),
      body: new Builder(builder: _buildBody),
      floatingActionButton: new FloatingActionButton(
        onPressed: _createTask,
        tooltip: 'Create a new Task',
        child: new Icon(Icons.add),
      ),
    );
  }
}
