import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/TodoItemModel.dart';
import 'package:todo/presenters/TodoDetailPresenter.dart';
import 'package:todo/views/TodoDetailView.dart';

class TodoDetailPage extends StatefulWidget {
  TodoDetailPage({Key key, @required this.item}) : super(key: key);

  final TodoItemModel item;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values
  // provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _TodoDetailPageState createState() => new _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage>
    implements TodoDetailView {
  TextEditingController _nameController;
  TextEditingController _notesController;
  TodoDetailPresenter _presenter;
  bool _isLoadingTask;

  _TodoDetailPageState() {
    _presenter = TodoDetailPresenter(this);
  }

  @override
  void showSaveTaskComplete(int succeed) {
    setState(() {
      _isLoadingTask = false;
    });
  }

  @override
  void showSaveTaskError() {
    setState(() {
      _isLoadingTask = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoadingTask = false;
    _nameController = new TextEditingController(text: widget.item.name);
    _notesController = new TextEditingController(text: widget.item.notes);
  }

  void _handleSave() {
    this.widget.item.name = _nameController.text;
    this.widget.item.notes = _notesController.text;

    _presenter.saveTodoItem(this.widget.item);
    Navigator.pop(context);
  }

  Widget _buildBody(BuildContext context) {
    return new SingleChildScrollView(
      child: new Padding(
        padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
        child: new Column(
          children: <Widget>[
            new Text(widget.item.id),
            new TextField(
              controller: _nameController,
              decoration: new InputDecoration(
                labelText: "Name",
              ),
            ),
            new TextField(
              maxLines: null, // unlimited
              controller: _notesController,
              decoration: new InputDecoration(
                labelText: "Notes",
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('Task'),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.save),
              onPressed: _handleSave,
              tooltip: 'Save',
            ),
          ],
        ),
        body: new Builder(
          builder: _buildBody,
        ));
  }
}
