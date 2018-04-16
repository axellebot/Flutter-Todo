import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/TodoItemModel.dart';
import 'package:todo/views/TodoItemCell.dart';

class TodoDetailPage extends StatefulWidget {
  TodoDetailPage({Key key, this.item}) : super(key: key);

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

class _TodoDetailPageState extends State<TodoDetailPage> {
  TextEditingController _nameController;
  TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _nameController =new TextEditingController(text: widget.item.name);
    _notesController=new TextEditingController(text: widget.item.notes);
  }

  void _handleSave() {
    Navigator.pop(context);
  }

  Widget _buildBody(BuildContext context) {
    return new SingleChildScrollView(
      child: new Padding(
        padding: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
        child: new Column(
          children: <Widget>[
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

/// Keeps a Dart List in sync with an AnimatedList.
///
/// The [insert] and [removeAt] methods apply to both the internal list and the
/// animated list that belongs to [listKey].
///
/// This class only exposes as much of the Dart List API as is needed by the
/// sample app. More list methods are easily added, however methods that mutate the
/// list must make the same changes to the animated list in terms of
/// [AnimatedListState.insertItem] and [AnimatedList.removeItem].
class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _elementList = new List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _elementList;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _elementList.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _elementList.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return removedItemBuilder(removedItem, context, animation);
        },
      );
    }
    return removedItem;
  }

  int get length => _elementList.length;

  E operator [](int index) => _elementList[index];

  int indexOf(E item) => _elementList.indexOf(item);
}
