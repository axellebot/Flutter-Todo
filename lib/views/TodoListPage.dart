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
  final GlobalKey<AnimatedListState> _listKey =
      new GlobalKey<AnimatedListState>();
  ListModel<TodoItemModel> _list;
  BuildContext context;

  // Used to build an item after it has been removed from the list. This method is
  // needed because a removed item remains  visible until its animation has
  // completed (even though it's gone as far this ListModel is concerned).
  // The widget will be used by the [AnimatedListState.removeItem] method's
  // [AnimatedListRemovedItemBuilder] parameter.
  Widget _buildRemovedItem(
      TodoItemModel item, BuildContext context, Animation<double> animation) {
    return new TodoItemCell(
      animation: animation,
      todoItem: item,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  void initList() {
    _list = new ListModel<TodoItemModel>(
      listKey: _listKey,
      initialItems: <TodoItemModel>[new TodoItemModel("Nom 1", "Notes 1")],
      removedItemBuilder: _buildRemovedItem,
    );
  }

  @override
  void initState() {
    super.initState();
    initList();
  }

  void _handleCreate(int index, TodoItemModel item) {
    _list.insert(index, item);
  }

  // TODO : Mutual access on list when item delete (cause crash on debug mode)
  void _handleDelete(int index, TodoItemModel todoItem) {
    _list._elementList.removeAt(index);
    _list._animatedList.removeItem(index,
        (BuildContext context, Animation<double> animation) {
      return null;
    });

    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text('You deleted an item'),
        action: new SnackBarAction(
            label: 'UNDO',
            onPressed: () {
              _handleCreate(index, todoItem);
            })));
  }

  // Insert the "next item" into the list model.
  void _createMockItem() {
    final int index = _list.length;
    _list.insert(
        index, new TodoItemModel("Todo ${index}", "Description row ${index}"));
  }

  // Used to build list items that haven't been removed.
  Widget _buildListItems(
      BuildContext context, int index, Animation<double> animation) {
    TodoItemModel todoItem = _list._elementList.elementAt(index);
    return TodoItemCell(
      onDelete: (DismissDirection direction) => _handleDelete(index, todoItem),
      todoItem: todoItem,
      animation: animation,
    );
  }

  Widget _buildBody(BuildContext context) {
    this.context = context;
    return new AnimatedList(
      key: _listKey,
      initialItemCount: _list.length,
      itemBuilder: _buildListItems,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('Todo List'),
          actions: <Widget>[
            new IconButton(
              icon: const Icon(Icons.add),
              onPressed: _createMockItem,
              tooltip: 'Create a new Task',
            ),
          ],
        ),
        body: new Builder(builder: _buildBody));
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
      _animatedList.removeItem(index,
          (BuildContext context, Animation<double> animation) {
        return removedItemBuilder(removedItem, context, animation);
      });
    }
    return removedItem;
  }

  int get length => _elementList.length;

  E operator [](int index) => _elementList[index];

  int indexOf(E item) => _elementList.indexOf(item);
}
